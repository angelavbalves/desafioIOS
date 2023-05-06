//
//  PullRequestsView.swift
//  RepoPop
//
//  Created by Angela Alves on 27/07/22.
//

import Foundation
import TinyConstraints
import UIKit

class PullRequestsView: RPView {

    // MARK: Properties
    private var pullRequests: [PullRequestResponseItem] = []
    private let openURL: (_ url: URL) -> Void
    private let presentAlert: (_ alertController: UIAlertController) -> Void
    private var isLoadingMorePullRequests: Bool = false
    private let fetchPullRequests: (_ isPaging: Bool) -> Void

    // MARK: Views
    private lazy var tableView = UITableView() .. {
        $0.delegate = self
        $0.dataSource = self
        $0.tableFooterView = RPView()
        $0.separatorStyle = .none
        $0.register(PullRequestsCell.self, forCellReuseIdentifier: PullRequestsCell.identifer)
        $0.prefetchDataSource = self
    }

    // MARK: Init
    init(
        openURL: @escaping (_ url: URL) -> Void,
        presentAlert: @escaping (_ alertController: UIAlertController) -> Void,
        fetchPullRequests: @escaping (_ isPaging: Bool) -> Void
    ) {
        self.openURL = openURL
        self.presentAlert = presentAlert
        self.fetchPullRequests = fetchPullRequests
        super.init()
    }

    override func configureSubviews() {
        addSubview(tableView)
    }

    override func configureConstraints() {
        tableView.edgesToSuperview(usingSafeArea: true)
    }

    // MARK: Aux
    func reloadTableView(with pullRequests: [PullRequestResponseItem]) {
        self.pullRequests = pullRequests
        tableView.reloadData()
    }
}

extension PullRequestsView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

extension PullRequestsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pullRequests.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PullRequestsCell.identifer, for: indexPath) as! PullRequestsCell

        let pull = pullRequests[indexPath.row]
        cell.setup(for: pull)

        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let pullRequestSelected = pullRequests[indexPath.row]
        guard
            let urlString = pullRequestSelected.html_url,
            let url = URL(string: urlString)
        else {
            let alert = UIAlertController(
                title: "Invalid URL",
                message: "The URL you entered is not valid. Please check and try again.",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            presentAlert(alert)
            return
        }
        openURL(url)
    }
}

extension PullRequestsView: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        let lastIndex = indexPaths.last?.row ?? 0
        let limit = pullRequests.endIndex - 10

        if
            lastIndex >= limit,
            !isLoadingMorePullRequests
        {
            isLoadingMorePullRequests = true
            fetchPullRequests(isLoadingMorePullRequests)
        }
    }
}
