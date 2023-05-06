//
//  PullRequestsViewController.swift
//  RepoPop
//
//  Created by Angela Alves on 27/07/22.
//

import Foundation
import UIKit
import RxSwift

class PullRequestsViewController: RPViewController {

    // MARK: Properties
    lazy var pullRequestsView = PullRequestsView(openURL: openURL(_:), presentAlert: presentAlert(_:))
    private let disposeBag = DisposeBag()
    private let viewModel: PullRequestsViewModel

    // MARK: Init
    init(viewModel: PullRequestsViewModel) {
        self.viewModel = viewModel
        super.init()
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
        viewModel
            .fetchPullRequests(viewModel.repository.owner.login, viewModel.repository.name)
            .subscribe(onNext: { [weak self] response in
                DispatchQueue.main.async {
                    self?
                        .pullRequestsView
                        .reloadTableView(with: response)
                    self?.loadingView.hide()
                }
            })
            .disposed(by: disposeBag)
    }

    func openURL(_ url: URL) {
        UIApplication.shared.open(url)
    }

    func presentAlert(_ alertController: UIAlertController) {
        present(alertController, animated: true)
    }
}
