//
//  PullRequestsViewController.swift
//  RepoPop
//
//  Created by Angela Alves on 27/07/22.
//

import Foundation
import RxSwift
import UIKit

class PullRequestsViewController: RPViewController {

    // MARK: Properties
    lazy var pullRequestsView = PullRequestsView(
        openURL: openURL(_:),
        presentAlert: presentAlert(_:),
        fetchPullRequests: fetchPullRequests(_:)
    )
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

    override func viewWillAppear(_ animated: Bool) {
        fetchPullRequests(false)
    }

    // MARK: Aux
    func fetchPullRequests(_ isPaging: Bool) {
        loadingView.show()
        viewModel
            .fetchPullRequests(
                isPaging,
                viewModel.repository.owner.login,
                viewModel.repository.name
            )
            .subscribe(onNext: { [weak self] response in
                           DispatchQueue.main.async {
                               if response.isEmpty {
                                   self?.warningView.show(DisplayType.empty("No pull requests found"))
                               }
                               self?
                                   .pullRequestsView
                                   .reloadTableView(with: response)
                               self?.loadingView.hide()
                           }
                       },
                       onError: { [weak self] error in
                           DispatchQueue.main.async {
                               self?.warningView.show(DisplayType.error(error))
                           }
                       })
            .disposed(by: disposeBag)
    }

    func openURL(_ url: URL) {
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            let alert = UIAlertController(
                title: "Something went wrong",
                message: "We couldn't open the browser with the URL provided",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            presentAlert(alert)
        }
    }

    func presentAlert(_ alertController: UIAlertController) {
        present(alertController, animated: true)
    }

    func setCloseButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .close,
            target: self,
            action: #selector(closeButtonDidTap)
        )
        configureNav()
    }

    @objc func closeButtonDidTap() {
        dismiss(animated: true)
    }

    private func configureNav() {
        navigationController?.navigationBar.isTranslucent = false
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = AppColors.lightGreen

        navigationController?.navigationBar.tintColor = .black

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
}
