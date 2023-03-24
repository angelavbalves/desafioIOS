//
//  PopularRepositoriesView.swift
//  RepoPop
//
//  Created by Angela Alves on 25/07/22.
//

import Foundation
import UIKit

class PopularRepositoriesView: RPView {

    // MARK: Properties
    private(set) var popularRepositories: [RepositoryResponseItem] = []
    var filteredRepositories: [RepositoryResponseItem] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    private let fetchAllRepositories: (_ isPagging: Bool) -> Void
    private let didTapOnRow: (_ repository: RepositoryResponseItem) -> Void
    private var isFiltering = false
    private var isLoadingMoreRepositories = false

    // MARK: Init
    init(
        fetchAllRepositories: @escaping (_ isPagging: Bool) -> Void,
        didTapOnRow: @escaping (_ repository: RepositoryResponseItem) -> Void
    ) {
        self.fetchAllRepositories = fetchAllRepositories
        self.didTapOnRow = didTapOnRow
        super.init()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Views
    private lazy var tableView = UITableView() .. {
        $0.delegate = self
        $0.dataSource = self
        $0.separatorStyle = .none
        $0.register(PopularRepositoriesCell.self, forCellReuseIdentifier: PopularRepositoriesCell.identifer)
        $0.prefetchDataSource = self
    }

    // MARK: Aux
    override func configureSubviews() {
        addSubview(tableView)
    }

    override func configureConstraints() {
        tableView.edgesToSuperview(usingSafeArea: true)
    }

    func reloadTableViewWith(popularRepositories: [RepositoryResponseItem]) {
        self.popularRepositories = popularRepositories
        filteredRepositories += popularRepositories
        tableView.reloadData()
        isLoadingMoreRepositories = false
    }

    func updateViewWithSearchResults(_ results: [RepositoryResponseItem]) {
        filteredRepositories = results
        isFiltering = true
        tableView.reloadData()
    }

    func resetList() {
        filteredRepositories = popularRepositories
        isFiltering = false
        tableView.reloadData()
    }
}

extension PopularRepositoriesView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

extension PopularRepositoriesView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredRepositories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PopularRepositoriesCell.identifer, for: indexPath) as! PopularRepositoriesCell

        let repository = filteredRepositories[indexPath.row]
        cell.setup(for: repository)

        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let repository = filteredRepositories[indexPath.row]
        didTapOnRow(repository)
    }
}

extension PopularRepositoriesView: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        let lastIndex = indexPaths.last?.row ?? 0
        let limit = filteredRepositories.endIndex - 10

        if
            lastIndex >= limit,
            !isLoadingMoreRepositories
        {
            isLoadingMoreRepositories = true
            fetchAllRepositories(isLoadingMoreRepositories)
        }
    }
}
