//
//  AppCoordinator.swift
//  RepoPop
//
//  Created by Angela Alves on 07/03/23.
//

import Foundation
import UIKit

class AppCoordinator: CoordinatorProtocol {

    // MARK: - Properties
    var window: UIWindow
    var navController: UINavigationController? { window.rootViewController as? UINavigationController }
    var childCoordinator: [CoordinatorProtocol] = []

    // MARK: - Init
    init(window: UIWindow) {
        self.window = window
        window.makeKeyAndVisible()
        window.rootViewController = UINavigationController()
    }

    func start() {
        let viewModel = SearchViewModel(coordinator: self)
        let controller = SearchController(viewModel: viewModel)
        navController?.setViewControllers([controller], animated: true)
    }

    // MARK: - Routes
    func showPullRequestList(_ repository: RepositoryResponseItem) {
        let viewModel = PullRequestsViewModel(
            repository: repository,
            coordinator: self
        )
        let controller = PullRequestsViewController(viewModel: viewModel)
        navController?.present(controller, animated: true)
    }

    func searchForRepositories(of language: String) {
        let viewModel = PopularRepositoriesViewModel(coordinator: self)
        let controller = PopularRepositoresViewController(
            language: language,
            viewModel: viewModel
        )
        navController?.pushViewController(controller, animated: true)
    }
}
