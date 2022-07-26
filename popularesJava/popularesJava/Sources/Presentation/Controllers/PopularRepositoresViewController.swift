//
//  ViewController.swift
//  popularesJava
//
//  Created by Angela Alves on 25/07/22.
//

import UIKit

class PopularRepositoresViewController: UIViewController {

    private lazy var viewPopularRepositories = PopularRepositoriesView()

    override func loadView() {
        view = viewPopularRepositories
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "GitHub JavaPop"
        navigationController?.navigationBar.backgroundColor = .darkGray
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }

    override func viewWillAppear(_ animated: Bool) {
        fetchRepositories()
    }

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
