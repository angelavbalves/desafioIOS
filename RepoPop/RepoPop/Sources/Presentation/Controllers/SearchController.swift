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
    lazy var searchView = SearchView(didTapOnSearchButton: didTapOnSearchButton(_:))

    override func loadView() {
        view = searchView
    }

    override func viewDidLoad() {
        searchView.backgroundColor = .white
    }

    // MARK: Aux
    func didTapOnSearchButton(_ language: String) {
        let controller = PopularRepositoresViewController(language: language)
        navigationController?.pushViewController(controller, animated: true)
    }
}
