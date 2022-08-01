//
//  Repository.swift
//  popularesJava
//
//  Created by Angela Alves on 25/07/22.
//

import Foundation

struct RepositoryResponse: Codable {
    let items: [RepositoryResponseItem]
}

// MARK: - RepositoryResponseItem
struct RepositoryResponseItem: Codable {
    let id: Int
    let name, fullName: String
    let owner: OwnerResponse
    let htmlURL: String
    let description: String?
    let url, subscriptionURL: String
    let pullsURL: String
    let updatedAt: String
    let stargazersCount, forks: Int

    struct OwnerResponse: Codable {
        let login: String
        let avatarURL: String

        enum CodingKeys: String, CodingKey {
            case login
            case avatarURL = "avatar_url"
        }
    }

    enum CodingKeys: String, CodingKey {
        case id, name, description, url, forks, owner
        case fullName = "full_name"
        case htmlURL = "html_url"
        case subscriptionURL = "subscription_url"
        case pullsURL = "pulls_url"
        case updatedAt = "updated_at"
        case stargazersCount = "stargazers_count"
    }
}
