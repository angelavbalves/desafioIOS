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
    var loadingView = JPLoadingView()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(loadingView)
        setupConstraintsView()
    }

    // MARK: Aux
    func setupConstraintsView() {
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}
