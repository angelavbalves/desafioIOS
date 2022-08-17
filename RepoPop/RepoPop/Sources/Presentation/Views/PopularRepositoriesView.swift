//
//  PopularRepositoriesView.swift
//  RepoPop
//
//  Created by Angela Alves on 25/07/22.
//

import Foundation
import UIKit

class PopularRepositoriesView: UIView {

    // MARK: Properties
    private(set) var popularRepositories: [RepositoryResponseItem] = []
    var filteredRepositories: [RepositoryResponseItem] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    private var isFiltering = false
    private var isLoadingNextPage = false

    var delegate: PopularRepositoresViewControllerDelegate?

    // MARK: Init
    init(delegate: PopularRepositoresViewControllerDelegate) {
        self.delegate = delegate
        super.init(frame: .zero)
        addSubview(tableView)
        setupConstraints()
        tableView.register(PopularRepositoriesCell.self, forCellReuseIdentifier: PopularRepositoriesCell.identifer)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Views
    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.delegate = self
        tv.dataSource = self

        return tv
    }()

    // MARK: Aux
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),

        ])
    }

    func reloadTableViewWith(popularRepositories: [RepositoryResponseItem]) {
        self.popularRepositories = popularRepositories
        filteredRepositories += popularRepositories
        tableView.reloadData()
        isLoadingNextPage = false
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

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        let distanceFromBottom = contentHeight - offsetY

        if
            !isFiltering,
            !isLoadingNextPage,
            contentHeight > height,
            distanceFromBottom < height
        {
            isLoadingNextPage = true
            delegate?.fetchRepositories()
        }
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
        delegate?.userDidTapOnTheRow(repository)
    }
}
