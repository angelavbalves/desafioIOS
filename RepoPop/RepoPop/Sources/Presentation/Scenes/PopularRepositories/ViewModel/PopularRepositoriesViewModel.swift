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

    // MARK: - Init
    init(coordinator: AppCoordinator?,
         service: RPService = .live())
    {
        self.coordinator = coordinator
        self.service = service
    }

    func fetchRepositories(_ language: String, _ page: Int) -> Observable<RepositoryResponse> {
        service
            .repositories(
                "https://api.github.com",
                ApiEndpoints
                    .repository(
                        language: language,
                        page: page
                    )
            )
    }

    func showPullRequestsList(_ repository: RepositoryResponseItem) {
        coordinator?.showPullRequestList(repository)
    }
}
