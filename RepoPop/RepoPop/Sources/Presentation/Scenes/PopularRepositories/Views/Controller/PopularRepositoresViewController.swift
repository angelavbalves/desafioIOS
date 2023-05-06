//
//  ViewController.swift
//  RepoPop
//
//  Created by Angela Alves on 25/07/22.
//

import RxSwift
import UIKit

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
        navigationController?.navigationBar.isHidden = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        clearFilter()
    }

    func configureNav() {
        navigationItem.title = language
        navigationController?.navigationBar.isTranslucent = false
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = AppColors.lightGreen

        navigationController?.navigationBar.tintColor = .black

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance

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
                               if repositories.isEmpty {
                                   self?.warningView.show(DisplayType.empty("No repositories found"))
                               } else {
                                   self?
                                       .popularRepositoriesView
                                       .reloadTableViewWith(
                                           popularRepositories: repositories
                                       )
                                   self?.loadingView.hide()
                               }
                           }
                       },
                       onError: { [weak self] error in
                           DispatchQueue.main.async {
                               self?.warningView.show(DisplayType.error(error))
                           }
                       }
                    )
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
            if filteredRepositories.isEmpty {
                warningView.show(DisplayType.empty("No repositories found"))
            } else {
                warningView.hide()
            }
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
        searchBar.text = ""
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        filter()
    }
}
