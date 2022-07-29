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

    static func getRepositories(_ completion: @escaping (Result<RepositoryResponse, RepositoryErrorState>) -> Void) {
        if let url = URL(string: "https://api.github.com/search/repositories?q=language:Java&sort=stars&order=desc") {
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

//    static func getPullsRequest(_ number: Int, _ completion: @escaping (Result<PullRequestResponse, PullRequestErrorState>) -> Void) {
//        if let url = URL(string: "https://api.github.com/repos/iluwatar/java-design-patterns/pulls/\(number)") {
//            let task = URLSession.shared.dataTask(with: url) { data, _, error in
//                guard let data = data else { return }
//
//                do {
//                    let repositories = try JSONDecoder().decode(PullRequestResponse.self, from: data)
//                    completion(.success(repositories))
//                } catch {
//                    print(error)
//                    completion(.failure(.generic))
//                }
//            }
//            task.resume()
//        }
//    }

    static func getPullsRequest(username: String, repositoryTitle: String, html: String, _ completion: @escaping (Result<[PullRequestResponseItem], PullRequestErrorState>) -> Void) {
        if let url = URL(string:
                            "https://api.github.com/repos/\(username)/\(repositoryTitle)/pulls") {
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
            }
            task.resume()
        }
    }
}
