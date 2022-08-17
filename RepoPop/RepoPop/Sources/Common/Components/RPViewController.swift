//
//  JPViewController.swift
//  RepoPop
//
//  Created by Angela Alves on 01/08/22.
//

import Foundation
import UIKit

class RPViewController: UIViewController {

    // MARK: Properties
    let loadingView = RPLoadingView()
    let emptyView = RPEmptyView()
    let errorView = RPErrorView()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(loadingView)
        view.addSubview(emptyView)
        view.addSubview(errorView)
        setupConstraintsView()
    }

    // MARK: Aux
    func setupConstraintsView() {
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        errorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            emptyView.topAnchor.constraint(equalTo: view.topAnchor),
            emptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            emptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            errorView.topAnchor.constraint(equalTo: view.topAnchor),
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            errorView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}
