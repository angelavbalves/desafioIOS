//
//  PullsRequestView.swift
//  popularesJava
//
//  Created by Angela Alves on 27/07/22.
//

import Foundation
import UIKit

class PullsRequestView: UIView {

    // MARK: Properties
    var pullsRequest: [PullRequestResponseItem] = []
    var openURL: (_ url: URL) -> Void
    var presentAlert: (_ alertController: UIAlertController) -> Void

    // MARK: Init
    init(openURL: @escaping (_ url: URL) -> Void, presentAlert: @escaping (_ alertController: UIAlertController) -> Void) {
        self.openURL = openURL
        self.presentAlert = presentAlert
        super.init(frame: .zero)
        tableView.register(PullsRequestCell.self, forCellReuseIdentifier: PullsRequestCell.identifer)
        addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor),
            tableView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor)
        ])
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Views
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self

        return tableView
    }()

    // MARK: Aux
    func reloadTableViewWith(pullsRequest: [PullRequestResponseItem]) {
        self.pullsRequest = pullsRequest
        print("😀 - \(pullsRequest.count)")
        tableView.reloadData()
    }
}

extension PullsRequestView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

extension PullsRequestView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pullsRequest.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PullsRequestCell.identifer, for: indexPath) as! PullsRequestCell

        let pulls = pullsRequest[indexPath.row]
        cell.setup(for: pulls)

        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let pullSelect = pullsRequest[indexPath.row]
        guard let pullHtmlUrl = URL(string: pullSelect.html_url ?? "") else {
            let alert = UIAlertController(title: "Error", message: "There isn't url to open in browser", preferredStyle: .alert)
            presentAlert(alert)
            return
        }
        openURL(pullHtmlUrl)
    }
}
