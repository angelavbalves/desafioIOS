//
//  Service.swift
//  RepoPop
//
//  Created by Angela Alves on 25/07/22.
//

import Foundation

class Service {

    static let dispatchGroup = DispatchGroup()
    static var number = 1

    static func makeRequest<T: Decodable>(endpoint: Endpoint, page: Int = 1, language: String = "", _ completion: @escaping (Result<T, ErrorState>) -> Void) {
        if let url = makeUrlFrom(endpoint: endpoint) {
            let task = URLSession.shared.dataTask(with: url) { data, response, _ in
                guard let data = data else { return }

                if let response = response as? HTTPURLResponse {
                    switch response.statusCode {
                        case 200...299:
                            if let obj: T = decode(data) {
                                completion(.success(obj))
                            } else {
                                completion(.failure(.generic))
                            }
                        case 300...399:
                            return
                        case 400...499:
                            completion(.failure(.badRequest))
                            return
                        case 500...599:
                            return
                        default:
                            return
                    }
                }
            }
            task.resume()
        } else {
            completion(.failure(.generic))
        }
    }

    private static func makeUrlFrom(endpoint: Endpoint) -> URLRequest? {
        guard let url = buildUrlFrom(endpoint: endpoint) else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method
        return urlRequest
    }

    private static func buildUrlFrom(endpoint: Endpoint) -> URL? {
        var component = URLComponents()
        component.scheme = "https"
        component.host = endpoint.host
        component.path = endpoint.path
        component.queryItems = endpoint.query
        if !endpoint.query.isEmpty {
            component.query = component.query?.insertString("q=")
        }

        return component.url
    }

    private static func decode<T: Decodable>(_ data: Data) -> T? {
        do {
            let repositories = try JSONDecoder().decode(T.self, from: data)
            return repositories
        } catch {
            print(error)
        }
        return nil
    }
}

extension String {
    func insertString(_ string: String) -> String {
        string + self
    }
}
