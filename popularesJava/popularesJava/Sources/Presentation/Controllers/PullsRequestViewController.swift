//
//  PullsRequestViewController.swift
//  popularesJava
//
//  Created by Angela Alves on 27/07/22.
//

import Foundation
import UIKit

class PullsRequestViewController: UIViewController {

    // MARK: Properties
    lazy var viewPulls = PullsRequestView(openURL: openURL(_:), presentAlert: presentAlert(_:))
    let username: String
    let repositoryTitle: String
//    let html: String

    // MARK: Init
    init(username: String, repositoryTitle: String) {
        self.username = username
        self.repositoryTitle = repositoryTitle
//        self.html = html
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Life Cycle
    override func loadView() {
        view = viewPulls
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        fetchPullsRequest()
    }

    // MARK: Aux
    func fetchPullsRequest() {
        Service.getPullsRequest(username: username, repositoryTitle: repositoryTitle) { result in
            switch result {
                case let .success(pullRequestResults):
                    DispatchQueue.main.async { [weak self] in
                        self?.viewPulls.reloadTableViewWith(pullsRequest: pullRequestResults)
                    }
                case .failure: return
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
