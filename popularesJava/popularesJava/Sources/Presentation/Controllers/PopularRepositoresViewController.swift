//
//  ViewController.swift
//  popularesJava
//
//  Created by Angela Alves on 25/07/22.
//

import UIKit

protocol PopularRepositoresViewControllerDelegate {
    func fetchRepositories()
}

protocol PopularDelegate {
    func userDidTapOnTheRow(_ repository: RepositoryResponseItem)
}

class PopularRepositoresViewController: UIViewController {

    // MARK: Properties
    private lazy var viewPopularRepositories = PopularRepositoriesView(delegate: self)

    // MARK: Life Cycle
    override func loadView() {
        view = viewPopularRepositories
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "GitHub JavaPop"
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = .darkGray
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
    }

    override func viewWillAppear(_ animated: Bool) {
        fetchRepositories()
    }
}

extension PopularRepositoresViewController: PopularRepositoresViewControllerDelegate {
    func fetchRepositories() {
        Service.getRepositories { result in
            switch result {
                case let .success(repositoryResult):
                    DispatchQueue.main.async { [weak self] in
                        self?.viewPopularRepositories.reloadTableViewWith(popularRepositories: repositoryResult.items)
                    }
                case .failure:
                    return
            }
        }
    }
}

extension PopularRepositoresViewController: PopularDelegate {
    func userDidTapOnTheRow(_ repository: RepositoryResponseItem) {
        let controller = PullsRequestViewController(username: repository.owner.login, repositoryTitle: repository.name)
        navigationController?.pushViewController(controller, animated: true)
    }
}
