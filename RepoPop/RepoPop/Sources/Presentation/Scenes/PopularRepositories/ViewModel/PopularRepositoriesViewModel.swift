//
//  PopularRepositoriesViewModel.swift
//  RepoPop
//
//  Created by Angela Alves on 07/03/23.
//

import Foundation
import RxSwift
import UIKit

class PopularRepositoriesViewModel {

    // MARK: - Properties
    private let service: RPService
    private let coordinator: AppCoordinator?
    private var currentPagePopularRepositories = 1
    private var currentPageFilteredRepositories = 1

    // MARK: - Init
    init(
        coordinator: AppCoordinator?,
        service: RPService = .live()
    ) {
        self.coordinator = coordinator
        self.service = service
    }

    func fetchRepositories(_ isPaging: Bool, _ language: String) -> Observable<RepositoryResponse> {
        if !isPaging { currentPagePopularRepositories = 1 }
        let repositories = service
            .getRepositories(
                "https://api.github.com",
                ApiEndpoints
                    .repository(
                        language: language,
                        page: currentPagePopularRepositories
                    )
            )
        currentPagePopularRepositories += 1
        return repositories
    }

    func showPullRequestsList(_ repository: RepositoryResponseItem) {
        coordinator?.showPullRequestList(repository)
    }
}
