//
//  JPViewController.swift
//  popularesJava
//
//  Created by Angela Alves on 01/08/22.
//

import Foundation
import UIKit

class JPViewController: UIViewController {

    // MARK: Properties
    let loadingView = JPLoadingView()
    let emptyView = JPEmptyView(title: "It's clean!",
                                     description: "There isn't pull requests in this repository",
                                     image: UIImage(named: "emptypullrequest")!)

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(loadingView)
        view.addSubview(emptyView)
        setupConstraintsView()
    }

    // MARK: Aux
    func setupConstraintsView() {
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            emptyView.topAnchor.constraint(equalTo: view.topAnchor),
            emptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            emptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}
