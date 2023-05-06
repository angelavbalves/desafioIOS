//
//  PullRequestsViewModel.swift
//  RepoPop
//
//  Created by Angela Alves on 07/03/23.
//

import Foundation
import RxSwift

class PullRequestsViewModel {

    // MARK: - Properties
    private let service: RPService
    private let coordinator: AppCoordinator?
    let repository: RepositoryResponseItem

    // MARK: - Init
    init(
        repository: RepositoryResponseItem,
        coordinator: AppCoordinator?,
        service: RPService = .live()
    ) {
        self.repository = repository
        self.coordinator = coordinator
        self.service = service
    }

    func fetchPullRequests(_ username: String, _ title: String) -> Observable<[PullRequestResponseItem]> {
        service
            .pullRequests(
                "https://api.github.com",
                ApiEndpoints
                    .pullRequest(
                        username: username,
                        repositoryTitle: title)
            )
    }
}
