//
//  PullRequestsViewController.swift
//  RepoPop
//
//  Created by Angela Alves on 27/07/22.
//

import Foundation
import UIKit

class PullRequestsViewController: RPViewController {

    // MARK: Properties
    lazy var pullRequestsView = PullRequestsView(openURL: openURL(_:), presentAlert: presentAlert(_:))
    let username: String
    let repositoryTitle: String

    // MARK: Init
    init(username: String, repositoryTitle: String) {
        self.username = username
        self.repositoryTitle = repositoryTitle
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Life Cycle
    override func loadView() {
        view = pullRequestsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        fetchPullRequests()
    }

    // MARK: Aux

    func fetchPullRequests() {
        loadingView.show()
        Service.makeRequest(endpoint: ApiEndpoints.pullRequest(username: username, repositoryTitle: repositoryTitle)) { (result: Result<[PullRequestResponseItem], ErrorState>) in
            switch result {
                case let .success(pullRequestResults):
                    DispatchQueue.main.async { [weak self] in
                        if pullRequestResults.isEmpty {
                            self?.emptyView.show(title: "It's clean!", image: UIImage(named: "emptypullrequest")!)
                        }
                        self?.pullRequestsView.reloadTableView(with: pullRequestResults)
                        self?.loadingView.hide()
                    }
                case .failure:
                    DispatchQueue.main.async { [weak self] in
                        self?.errorView.show(
                            title: "Ops, something went wrong here!",
                            image: UIImage(named: "errorImage")!,
                            retryAction: self?.fetchPullRequests
                        )
                    }
            }
        }
    }

    func openURL(_ url: URL) {
        UIApplication.shared.open(url)
    }

    func presentAlert(_ alertController: UIAlertController) {
        present(alertController, animated: true)
    }
}
