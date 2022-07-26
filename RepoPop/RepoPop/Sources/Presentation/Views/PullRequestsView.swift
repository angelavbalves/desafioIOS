//
//  PullRequestsView.swift
//  RepoPop
//
//  Created by Angela Alves on 27/07/22.
//

import Foundation
import UIKit

class PullRequestsView: RPView {

    // MARK: Properties
    private var pullRequests: [PullRequestResponseItem] = []
    private let openURL: (_ url: URL) -> Void
    private let presentAlert: (_ alertController: UIAlertController) -> Void

    // MARK: Views
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = RPView()

        return tableView
    }()

    // MARK: Init
    init(openURL: @escaping (_ url: URL) -> Void, presentAlert: @escaping (_ alertController: UIAlertController) -> Void) {
        self.openURL = openURL
        self.presentAlert = presentAlert
        super.init()
        tableView.register(PullRequestsCell.self, forCellReuseIdentifier: PullRequestsCell.identifer)
    }

    override func configureSubviews() {
        addSubview(tableView)
    }

    override func configureConstraints() {
        NSLayoutConstraint.activate([
            tableView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor),
            tableView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor)
        ])
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
        let pullSelect = pullRequests[indexPath.row]
        guard let pullHtmlUrl = URL(string: pullSelect.html_url ?? "") else {
            let alert = UIAlertController(title: "Error", message: "There isn't url to open in browser", preferredStyle: .alert)
            presentAlert(alert)
            return
        }
        openURL(pullHtmlUrl)
    }
}
