//
//  EmptyView.swift
//  RepoPop
//
//  Created by Angela Alves on 01/08/22.
//

import Foundation
import TinyConstraints
import UIKit

enum DisplayType {
    case error(_ error: Swift.Error)
    case empty(_ title: String)
}

class RPWarningView: RPView {

    // MARK: Init
    override init() {
        super.init()
        backgroundColor = .white
        isHidden = true
    }

    // MARK: Views
    private lazy var card = RPShadowView()

    private let totalStackView = UIStackView() .. {
        $0.axis = .vertical
        $0.alignment = .center
    }

    private let icon = UIImageView() .. {
        $0.contentMode = .scaleAspectFit
    }

    private let titleLabel = UILabel() .. {
        $0.font = Fonts.title
        $0.tintColor = AppColors.darkGray
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
    }

    // MARK: Aux
    override func configureSubviews() {
        addSubview(card)
        card.addSubview(totalStackView)
        totalStackView.addArrangedSubview(icon)
        totalStackView.addArrangedSubview(titleLabel)
    }

    override func configureConstraints() {
        card.centerInSuperview(usingSafeArea: true)
        totalStackView.height(to: card, multiplier: 0.82)
        totalStackView.width(to: card, multiplier: 0.8)
        totalStackView.center(in: card)
        icon.width(to: totalStackView)
        icon.heightToWidth(of: icon)
    }

    func show(_ displayType: DisplayType) {
        switch displayType {
            case .error(let error):
                showErrorState(error)
            case .empty(let title):
                showEmptyState(title)
        }
        isHidden = false
    }

    func hide() {
        isHidden = true
    }

    private func showErrorState(_ error: Swift.Error) {
        if let error = error as? ErrorState {
            icon.image = UIImage(systemName: "exclamationmark.triangle.fill")?
                .withTintColor(
                    AppColors.darkGray,
                    renderingMode: .alwaysOriginal
                )
            switch error {
                case .generic(let description):
                    titleLabel.text = description
                case .noConnection(let description):
                    titleLabel.text = description
                case .badRequest(let description):
                    titleLabel.text = description
                case .invalidData(let description):
                    titleLabel.text = description
                case .redirectError(let description):
                    titleLabel.text = description
                case .unrecognizedError(let description):
                    titleLabel.text = description
            }
        }
    }

    private func showEmptyState(_ title: String) {
        titleLabel.text = title
        icon.image = UIImage(
            systemName: "folder.badge.minus")?
            .withTintColor(
                AppColors.darkGray,
                renderingMode: .alwaysOriginal
            )
    }
}
