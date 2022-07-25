//
//  ViewController.swift
//  popularesJava
//
//  Created by Angela Alves on 25/07/22.
//

import UIKit

class PopularRepositoresViewController: UIViewController {

    private lazy var viewPopularRepositories = PopularRepositoriesView()

    override func loadView() {
        view = viewPopularRepositories
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

