//
//  PullRequest.swift
//  popularesJava
//
//  Created by Angela Alves on 27/07/22.
//

import Foundation

struct PullRequestResponse: Codable {
    let items: [PullRequestResponseItem]
}

struct PullRequestResponseItem: Codable {
    let number: Int
    let title: String
    let user: User
    let body: String?
    let updated_at: String
    let html_url: String
}

struct User: Codable {
    let login: String
    let avatar_url: String
}
