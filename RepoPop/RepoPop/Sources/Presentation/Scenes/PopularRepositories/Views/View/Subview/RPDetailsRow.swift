//
//  RPDetailsRow.swift
//  RepoPop
//
//  Created by Angela Alves on 10/03/23.
//

import Foundation
import TinyConstraints
import UIKit

class RPDetailsRow: RPView {

    // MARK: - Views
    private let bottomView = RPShadowView()

    private let stackView = UIStackView() .. {
        $0.axis = .horizontal
        $0.spacing = Spacing.small
        $0.alignment = .center
    }

    let iconRow = UIImageView() .. {
        $0.contentMode = .scaleAspectFit
        $0.width(30)
        $0.height(30)
    }

    let info = UILabel() .. {
        $0.font = Fonts.subtitleLarge
        $0.numberOfLines = 0
        $0.textColor = .black
        $0.lineBreakMode = .byWordWrapping
    }

    override func configureSubviews() {
        addSubview(bottomView)
        addSubview(stackView)
        stackView.addArrangedSubview(iconRow)
        stackView.addArrangedSubview(info)
    }

    override func configureConstraints() {
        bottomView.edgesToSuperview(insets: .uniform(Spacing.medium))
        stackView.edges(to: bottomView, insets: .uniform(Spacing.medium))
    }
}
