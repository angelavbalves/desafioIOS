//
//  ViewController.swift
//  RepoPop
//
//  Created by Angela Alves on 25/07/22.
//

import UIKit
import RxSwift

class PopularRepositoresViewController: RPViewController {

    // MARK: Properties
    private lazy var popularRepositoriesView = PopularRepositoriesView(
        fetchRepositories: fetchRepositories,
        didTapOnRow: userDidTapOnTheRow(_:)
    )
    private let viewModel: PopularRepositoriesViewModel
    private var currentPage = 1
    private var language: String
    let searchBar = UISearchBar()
    private let disposeBag = DisposeBag()

    // MARK: Init
    init(
        language: String,
        viewModel: PopularRepositoriesViewModel
    ) {
        self.language = language
        self.viewModel = viewModel
        super.init()
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
        super.viewWillDisappear(animated)
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

    func fetchRepositories() {
        loadingView.show()
        viewModel
            .fetchRepositories(language, currentPage)
            .subscribe(onNext: { [weak self] repositoriesReponse in
                let repositories = repositoriesReponse.items
                DispatchQueue.main.async {
                    self?
                        .popularRepositoriesView
                        .reloadTableViewWith(
                            popularRepositories: repositories
                        )
                    self?.loadingView.hide()
                }
            })
            .disposed(by: disposeBag)
    }

    func userDidTapOnTheRow(_ repository: RepositoryResponseItem) {
        viewModel.showPullRequestsList(repository)
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
