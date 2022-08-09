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
    private lazy var popularRepositoriesView = PopularRepositoriesView(delegate: self)
    private var currentPage = 1
    private var language: String
    let searchBar = UISearchBar()

    // MARK: Init
    init(language: String) {
        self.language = language
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life Cycle
    override func loadView() {
        view = popularRepositoriesView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNav()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchRepositories()
    }

    func configureNav() {
        navigationItem.title = "GitHub RepoPop"
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = .darkGray
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray]

        searchBar.sizeToFit()
        searchBar.delegate = self
        showSearchBarButton(shouldShow: true)
    }

    func showSearchBarButton(shouldShow: Bool) {
        if shouldShow {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleShowSearchBar))
        } else {
            navigationItem.rightBarButtonItem = nil
        }
    }

    @objc func handleShowSearchBar() {
        searchBar.becomeFirstResponder()
        search(shouldShow: true)
    }

    func search(shouldShow: Bool) {
        showSearchBarButton(shouldShow: !shouldShow)
        searchBar.showsCancelButton = shouldShow
        navigationItem.titleView = shouldShow ? searchBar : nil
    }
}

extension PopularRepositoresViewController: PopularRepositoresViewControllerDelegate {
    func fetchRepositories() {
        loadingView.show()
        Service.getRepositories(page: currentPage, language: language) { result in
            switch result {
                case let .success(repositoryResult):
                    DispatchQueue.main.async { [weak self] in
                        self?.popularRepositoriesView.reloadTableViewWith(popularRepositories: repositoryResult.items)
                        self?.loadingView.hide()
                        self?.currentPage += 1
                    }
                case .failure:
                    return
            }
        }
    }

    func userDidTapOnTheRow(_ repository: RepositoryResponseItem) {
        let controller = PullRequestsViewController(username: repository.owner.login, repositoryTitle: repository.name)
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension PopularRepositoresViewController: UISearchBarDelegate {

    func searchBar(_: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            popularRepositoriesView.resetList()

        } else {
            let text = searchText.lowercased()
            let filteredRepositories = popularRepositoriesView.popularRepositories.filter { repository in
                repository.name.lowercased().contains(text)
            }
            popularRepositoriesView.updateViewWithSearchResults(filteredRepositories)
        }
    }

    func searchBarCancelButtonClicked(_: UISearchBar) {
        popularRepositoriesView.resetList()
        search(shouldShow: false)
    }
}
