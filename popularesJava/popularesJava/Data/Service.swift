//
//  Service.swift
//  popularesJava
//
//  Created by Angela Alves on 25/07/22.
//

import Foundation

class Service {
    enum RepositoryErrorState: Swift.Error {
        case generic
        case repositoryNotFound
        case noConnection
    }

    enum PullRequestErrorState: Swift.Error {
        case generic
        case repositoryNotFound
        case noConnection
    }

    static let dispatchGroup = DispatchGroup()
    static var number = 1
    static func getRepositories(page: Int, language: String, _ completion: @escaping (Result<RepositoryResponse, RepositoryErrorState>) -> Void) {
        print("🛑 Request - \(number)")
        number += 1
        if let url = URL(string: "https://api.github.com/search/repositories?q=language:\(language)&sort=stars&order=desc&page=\(page)") {
            let task = URLSession.shared.dataTask(with: url) { data, _, error in
                guard let data = data else { return }

                do {
                    let repositories = try JSONDecoder().decode(RepositoryResponse.self, from: data)
                    completion(.success(repositories))
                } catch {
                    print(error)
                    completion(.failure(.generic))
                }
            }
            task.resume()
        }
    }

    static func getPullRequests(username: String, repositoryTitle: String, _ completion: @escaping (Result<[PullRequestResponseItem], PullRequestErrorState>) -> Void) {
        dispatchGroup.enter()
        if let url = URL(string:
            "https://api.github.com/repos/\(username)/\(repositoryTitle)/pulls")
        {
            print("😀 - \(url)")
            let task = URLSession.shared.dataTask(with: url) { data, _, error in
                guard let data = data else { return }

                do {
                    let repositories = try JSONDecoder().decode([PullRequestResponseItem].self, from: data)
                    completion(.success(repositories))
                } catch {
                    print(error)
                    completion(.failure(.generic))
                }
                self.dispatchGroup.leave()
            }
            task.resume()
            dispatchGroup.wait()
        }
    }
}
