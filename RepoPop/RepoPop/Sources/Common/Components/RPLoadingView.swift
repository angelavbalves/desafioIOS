//
//  JPLoadingView.swift
//  RepoPop
//
//  Created by Angela Alves on 01/08/22.
//

import Foundation
import UIKit
import TinyConstraints

class RPLoadingView: RPView {

    // MARK: Init
    override init() {
        super.init()
        isHidden = true
        backgroundColor = .white
    }

    // MARK: View
    let activeIndicator = UIActivityIndicatorView(style: .large)

    // MARK: Aux
    override func configureSubviews() {
        addSubview(activeIndicator)
    }

    override func configureConstraints() {
        activeIndicator.centerInSuperview()
    }

    func show() {
        isHidden = false
        activeIndicator.startAnimating()
    }

    func hide() {
        isHidden = true
        activeIndicator.stopAnimating()
    }
}
