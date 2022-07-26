//
//  Service.swift
//  popularesJava
//
//  Created by Angela Alves on 25/07/22.
//

import Foundation
import UIKit

class Service {
    enum RepositoryErrorState: Swift.Error {
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
}

/*
{
    "id": 78131995,
    "node_id": "MDEwOlJlcG9zaXRvcnk3ODEzMTk5NQ==",
    "name": "google-foobar",
    "full_name": "n3a9/google-foobar",
    "private": false,
    "owner": {
        "login": "n3a9",
        "id": 7104017,
        "node_id": "MDQ6VXNlcjcxMDQwMTc=",
        "avatar_url": "https://avatars.githubusercontent.com/u/7104017?v=4",
        "gravatar_id": "",
        "url": "https://api.github.com/users/n3a9",
        "html_url": "https://github.com/n3a9",
        "followers_url": "https://api.github.com/users/n3a9/followers",
        "following_url": "https://api.github.com/users/n3a9/following{/other_user}",
        "gists_url": "https://api.github.com/users/n3a9/gists{/gist_id}",
        "starred_url": "https://api.github.com/users/n3a9/starred{/owner}{/repo}",
        "subscriptions_url": "https://api.github.com/users/n3a9/subscriptions",
        "organizations_url": "https://api.github.com/users/n3a9/orgs",
        "repos_url": "https://api.github.com/users/n3a9/repos",
        "events_url": "https://api.github.com/users/n3a9/events{/privacy}",
        "received_events_url": "https://api.github.com/users/n3a9/received_events",
        "type": "User",
        "site_admin": false
    },
    "html_url": "https://github.com/n3a9/google-foobar",
    "description": "My Google Foo Bar Challenges 🤓 🧮",
    "fork": false,
    "url": "https://api.github.com/repos/n3a9/google-foobar",
    "forks_url": "https://api.github.com/repos/n3a9/google-foobar/forks",
    "keys_url": "https://api.github.com/repos/n3a9/google-foobar/keys{/key_id}",
    "collaborators_url": "https://api.github.com/repos/n3a9/google-foobar/collaborators{/collaborator}",
    "teams_url": "https://api.github.com/repos/n3a9/google-foobar/teams",
    "hooks_url": "https://api.github.com/repos/n3a9/google-foobar/hooks",
    "issue_events_url": "https://api.github.com/repos/n3a9/google-foobar/issues/events{/number}",
    "events_url": "https://api.github.com/repos/n3a9/google-foobar/events",
    "assignees_url": "https://api.github.com/repos/n3a9/google-foobar/assignees{/user}",
    "branches_url": "https://api.github.com/repos/n3a9/google-foobar/branches{/branch}",
    "tags_url": "https://api.github.com/repos/n3a9/google-foobar/tags",
    "blobs_url": "https://api.github.com/repos/n3a9/google-foobar/git/blobs{/sha}",
    "git_tags_url": "https://api.github.com/repos/n3a9/google-foobar/git/tags{/sha}",
    "git_refs_url": "https://api.github.com/repos/n3a9/google-foobar/git/refs{/sha}",
    "trees_url": "https://api.github.com/repos/n3a9/google-foobar/git/trees{/sha}",
    "statuses_url": "https://api.github.com/repos/n3a9/google-foobar/statuses/{sha}",
    "languages_url": "https://api.github.com/repos/n3a9/google-foobar/languages",
    "stargazers_url": "https://api.github.com/repos/n3a9/google-foobar/stargazers",
    "contributors_url": "https://api.github.com/repos/n3a9/google-foobar/contributors",
    "subscribers_url": "https://api.github.com/repos/n3a9/google-foobar/subscribers",
    "subscription_url": "https://api.github.com/repos/n3a9/google-foobar/subscription",
    "commits_url": "https://api.github.com/repos/n3a9/google-foobar/commits{/sha}",
    "git_commits_url": "https://api.github.com/repos/n3a9/google-foobar/git/commits{/sha}",
    "comments_url": "https://api.github.com/repos/n3a9/google-foobar/comments{/number}",
    "issue_comment_url": "https://api.github.com/repos/n3a9/google-foobar/issues/comments{/number}",
    "contents_url": "https://api.github.com/repos/n3a9/google-foobar/contents/{+path}",
    "compare_url": "https://api.github.com/repos/n3a9/google-foobar/compare/{base}...{head}",
    "merges_url": "https://api.github.com/repos/n3a9/google-foobar/merges",
    "archive_url": "https://api.github.com/repos/n3a9/google-foobar/{archive_format}{/ref}",
    "downloads_url": "https://api.github.com/repos/n3a9/google-foobar/downloads",
    "issues_url": "https://api.github.com/repos/n3a9/google-foobar/issues{/number}",
    "pulls_url": "https://api.github.com/repos/n3a9/google-foobar/pulls{/number}",
    "milestones_url": "https://api.github.com/repos/n3a9/google-foobar/milestones{/number}",
    "notifications_url": "https://api.github.com/repos/n3a9/google-foobar/notifications{?since,all,participating}",
    "labels_url": "https://api.github.com/repos/n3a9/google-foobar/labels{/name}",
    "releases_url": "https://api.github.com/repos/n3a9/google-foobar/releases{/id}",
    "deployments_url": "https://api.github.com/repos/n3a9/google-foobar/deployments",
    "created_at": "2017-01-05T17:03:33Z",
    "updated_at": "2022-07-19T01:06:02Z",
    "pushed_at": "2021-01-05T13:56:40Z",
    "git_url": "git://github.com/n3a9/google-foobar.git",
    "ssh_url": "git@github.com:n3a9/google-foobar.git",
    "clone_url": "https://github.com/n3a9/google-foobar.git",
    "svn_url": "https://github.com/n3a9/google-foobar",
    "homepage": "",
    "size": 37,
    "stargazers_count": 258,
    "watchers_count": 258,
    "language": "Java",
    "has_issues": true,
    "has_projects": false,
    "has_downloads": true,
    "has_wiki": false,
    "has_pages": false,
    "forks_count": 91,
    "mirror_url": null,
    "archived": false,
    "disabled": false,
    "open_issues_count": 3,
    "license": null,
    "allow_forking": true,
    "is_template": false,
    "web_commit_signoff_required": false,
    "topics": [
    "foobar",
    "google",
    "interview-practice",
    "interview-questions"
    ],
    "visibility": "public",
    "forks": 91,
    "open_issues": 3,
    "watchers": 258,
    "default_branch": "master",
    "score": 1.0
},
*/
