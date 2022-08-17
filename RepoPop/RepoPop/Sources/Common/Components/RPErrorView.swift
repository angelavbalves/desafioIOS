//
//  JPErrorView.swift
//  RepoPop
//
//  Created by Angela Alves on 11/08/22.
//

import Foundation
import UIKit

class RPErrorView: RPView {

    var retryAction: (() -> Void)?

    override init() {
        super.init()
        backgroundColor = .white
        isHidden = true
    }

    private var totalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center

        return stackView
    }()

    private var errorImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.setContentHuggingPriority(.required, for: .vertical)

        return imageView
    }()

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.tintColor = .gray

        return label
    }()

    private var refreshButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Try again", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(retryButtonTappedAction), for: .touchUpInside)

        return button
    }()

    override func configureSubviews() {
        addSubview(totalStackView)
        totalStackView.addArrangedSubview(errorImage)
        totalStackView.addArrangedSubview(titleLabel)
        totalStackView.addArrangedSubview(refreshButton)
    }

    override func configureConstraints() {
        NSLayoutConstraint.activate([
            totalStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            totalStackView.centerYAnchor.constraint(equalTo: centerYAnchor),

            errorImage.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.3),
            errorImage.heightAnchor.constraint(equalTo: errorImage.widthAnchor)
        ])
    }

    func show(title: String, image: UIImage, retryAction: (() -> Void)?) {
        titleLabel.text = title
        errorImage.image = image
        self.retryAction = retryAction
        isHidden = false
    }

    func hide() {
        isHidden = true
    }

    @objc func retryButtonTappedAction() {
        retryAction?()
        hide()
    }
}
