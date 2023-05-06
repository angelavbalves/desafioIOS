//
//  JPViewController.swift
//  RepoPop
//
//  Created by Angela Alves on 01/08/22.
//

import Foundation
import UIKit
import TinyConstraints

class RPViewController: UIViewController {

    //  MARK: Init
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Properties
    let loadingView = RPLoadingView()
    let warningView = RPWarningView()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(loadingView)
        view.addSubview(warningView)
        setupConstraintsView()
    }

    // MARK: Aux
    func setupConstraintsView() {
        loadingView.edgesToSuperview(usingSafeArea: true)
        warningView.edgesToSuperview(usingSafeArea: true)
    }
}
