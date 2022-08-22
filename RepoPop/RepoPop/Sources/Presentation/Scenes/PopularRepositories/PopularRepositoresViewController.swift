//
//  ViewController.swift
//  RepoPop
//
//  Created by Angela Alves on 25/07/22.
//

import UIKit

protocol PopularRepositoresViewControllerDelegate {
    func fetchRepositories()
    func userDidTapOnTheRow(_ repository: RepositoryResponseItem)
}

class PopularRepositoresViewController: RPViewController {

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

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
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

    override func viewWillDisappear(_ animated: Bool) {
        clearFilter()
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
        Service.makeRequest(endpoint: ApiEndpoints.repository(language: language, page: currentPage)) { (result: Result<RepositoryResponse, ErrorState>) in
            switch result {
                case let .success(repositoryResult):
                    DispatchQueue.main.async { [weak self] in
                        guard !repositoryResult.items.isEmpty else {
                            self?.emptyView.show(title: "Ops! There's nothing to see here. Search again.", image: UIImage(named: "emptypullrequest")!)
                            return
                        }
                        self?.popularRepositoriesView.reloadTableViewWith(popularRepositories: repositoryResult.items)
                        self?.loadingView.hide()
                        self?.currentPage += 1
                    }
                case .failure:
                    DispatchQueue.main.async { [weak self] in
                        self?.errorView.show(
                            title: "Ops, something went wrong here!",
                            image: UIImage(named: "errorImage")!,
                            retryAction: self?.fetchRepositories
                        )
                    }
            }
        }
    }

    func userDidTapOnTheRow(_ repository: RepositoryResponseItem) {
        let controller = PullRequestsViewController(username: repository.owner.login, repositoryTitle: repository.name)
        navigationController?.pushViewController(controller, animated: true)
    }

    func clearFilter() {
        searchBar.resignFirstResponder()
        search(shouldShow: false)
        popularRepositoriesView.resetList()
    }

    func filter() {
        if searchBar.text == nil {
            popularRepositoriesView.resetList()
        } else {
            guard let text = searchBar.text?.lowercased() else { return }
            let filteredRepositories = popularRepositoriesView.popularRepositories.filter { repository in
                repository.name.lowercased().contains(text)
            }
            popularRepositoriesView.updateViewWithSearchResults(filteredRepositories)
        }
    }
}

extension PopularRepositoresViewController: UISearchBarDelegate {

    func searchBar(_: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            clearFilter()
        } else {
            filter()
        }
    }

    func searchBarCancelButtonClicked(_: UISearchBar) {
        clearFilter()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        filter()
    }
}
