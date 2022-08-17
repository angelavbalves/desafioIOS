//
//  Enums.swift
//  RepoPop
//
//  Created by Angela Alves on 10/08/22.
//

import Foundation

enum ApiEndpoints {
    case repository(language: String, page: Int)
    case pullRequest(username: String, repositoryTitle: String)
}

extension ApiEndpoints: Endpoint {
    var host: String {
        return "api.github.com"
    }

    var path: String {
        switch self {
            case .repository:
                return "/search/repositories"
            case .pullRequest(let username, let repositoryTitle):
                return "/repos/\(username)/\(repositoryTitle)/pulls"
        }
    }

    var method: String {
        return "get"
    }

    var query: [URLQueryItem] {
        switch self {
            case .repository(let language, let page):
                return [
                    .init(name: "language", value: language),
                    .init(name: "sort", value: "stars"),
                    .init(name: "order", value: "desc"),
                    .init(name: "page", value: "\(page)"),
                ]
            default:
                return []
        }
    }
}
