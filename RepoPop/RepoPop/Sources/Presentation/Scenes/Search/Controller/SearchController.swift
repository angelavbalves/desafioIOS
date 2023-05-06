//
//  SearchController.swift
//  RepoPop
//
//  Created by Angela Alves on 09/08/22.
//

import Foundation
import UIKit

class SearchController: RPViewController {

    //  MARK: Views
    lazy var searchView = SearchView(
        didTapOnSearchButton: didTapOnSearchButton(_:),
        showAlert: showAlert
    )

    //  MARK: Properties
    private let viewModel: SearchViewModel

    //  MARK: Init
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init()
    }

    // MARK: - Life Cycle
    override func loadView() {
        view = searchView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        searchView.backgroundColor = AppColors.lightGray
        shouldDismissKeyboardOnTap = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    // MARK: Aux
    func didTapOnSearchButton(_ language: String) {
        viewModel.searchForRepositories(of: language)
    }

    func showAlert() {
        let alert = UIAlertController(title: "Warning",
                                      message: "You must complete the search field with a language",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(
            title: "OK",
            style: .cancel)
        )
        present(alert, animated: true)
    }
}
