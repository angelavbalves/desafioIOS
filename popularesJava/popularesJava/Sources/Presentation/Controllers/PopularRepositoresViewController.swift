//
//  ViewController.swift
//  popularesJava
//
//  Created by Angela Alves on 25/07/22.
//

import UIKit

protocol PopularRepositoresViewControllerDelegate {
    func fetchRepositories()
    func userDidTapOnTheRow(_ repository: RepositoryResponseItem)
}

class PopularRepositoresViewController: JPViewController {

    // MARK: Properties
    private lazy var viewPopularRepositories = PopularRepositoriesView(delegate: self)
    var currentPage = 1

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
        super.viewWillAppear(animated)
        fetchRepositories()
    }
}

extension PopularRepositoresViewController: PopularRepositoresViewControllerDelegate {
    func fetchRepositories() {
        loadingView.show()
        Service.getRepositories(page: currentPage) { result in
            switch result {
                case let .success(repositoryResult):
                    DispatchQueue.main.async { [weak self] in
                        self?.viewPopularRepositories.reloadTableViewWith(popularRepositories: repositoryResult.items)
                        self?.loadingView.hide()
                        self?.currentPage += 1
                    }
                case .failure:
                    return
            }
        }
    }

    func userDidTapOnTheRow(_ repository: RepositoryResponseItem) {
        let controller = PullsRequestViewController(username: repository.owner.login, repositoryTitle: repository.name)
        navigationController?.pushViewController(controller, animated: true)
    }
}
