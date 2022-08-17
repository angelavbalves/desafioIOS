//
//  EmptyView.swift
//  RepoPop
//
//  Created by Angela Alves on 01/08/22.
//

import Foundation
import UIKit

class RPEmptyView: UIView {

    // MARK: Init
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        addSubviews()
        setupConstraints()
        isHidden = true
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Views
    private var totalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center

        return stackView
    }()

    private var emptyImage: UIImageView = {
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
        label.numberOfLines = 0

        return label
    }()

    // MARK: Aux
    func addSubviews() {
        addSubview(totalStackView)
        totalStackView.addArrangedSubview(emptyImage)
        totalStackView.addArrangedSubview(titleLabel)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            totalStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            totalStackView.centerYAnchor.constraint(equalTo: centerYAnchor),

            emptyImage.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.3),
            emptyImage.heightAnchor.constraint(equalTo: emptyImage.widthAnchor)
        ])
    }

    func show(title: String, image: UIImage) {
        titleLabel.text = title
        emptyImage.image = image
        isHidden = false
    }

    func hide() {
        isHidden = true
    }
}
