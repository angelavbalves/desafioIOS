//
//  SearchViewModel.swift
//  RepoPop
//
//  Created by Angela Alves on 07/03/23.
//

import Foundation

class SearchViewModel {

    // MARK: - Properties
    private let coordinator: AppCoordinator?

    // MARK: - Init
    init(coordinator: AppCoordinator?) {
        self.coordinator = coordinator
    }

    func searchForRepositories(of language: String) {
        coordinator?.searchForRepositories(of: language)
    }
}
