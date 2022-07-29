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
    lazy var viewPulls = PullsRequestView(openURL: openURL)
    let username: String
    let repositoryTitle: String
    let html: String

    // MARK: Init
    init(username: String, repositoryTitle: String, html: String) {
        self.username = username
        self.repositoryTitle = repositoryTitle
        self.html = html
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
        Service.getPullsRequest(username: username, repositoryTitle: repositoryTitle, html: html) { result in
            switch result {
                case let .success(pullRequestResults):
                    DispatchQueue.main.async { [weak self] in
                        self?.viewPulls.reloadTableViewWith(pullsRequest: pullRequestResults)
                    }
                case .failure: return
            }
        }
    }

    func openURL() {
        if let html = URL(string: html) {
            UIApplication.shared.open(html)
        }
    }
}
