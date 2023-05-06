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
    private var currentPage = 1

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

    func fetchPullRequests(_ isPaging: Bool, _ username: String, _ title: String) -> Observable<[PullRequestResponseItem]> {
        if !isPaging { currentPage = 1 }
        let pullRequests = service
            .getPullRequests(
                "https://api.github.com",
                ApiEndpoints
                    .pullRequest(
                        username: username,
                        repositoryTitle: title,
                        page: currentPage
                    )
            )
        currentPage += 1
        return pullRequests
    }
}
