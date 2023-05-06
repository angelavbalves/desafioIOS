//
//  RPView.swift
//  RepoPop
//
//  Created by Angela Alves on 17/08/22.
//

import Foundation
import UIKit

class RPView: UIView {

    init() {
        super.init(frame: .zero)
        configureSubviews()
        configureConstraints()
        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Aux
    func configureSubviews() {}
    func configureConstraints() {}
    func setupView() {}
}
