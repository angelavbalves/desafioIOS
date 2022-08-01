//
//  EmptyView.swift
//  popularesJava
//
//  Created by Angela Alves on 01/08/22.
//

import Foundation
import UIKit

class JPEmptyView: UIView {

    init(title: String, description: String, image: UIImage) {
        super.init(frame: .zero)
        backgroundColor = .white
        addSubviews()
        setupConstraints()
        setup(title: title, description: description, image: image)
        isHidden = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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

        return imageView
    }()

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.tintColor = .gray

        return label
    }()

    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.tintColor = .lightGray

        return label
    }()

    func addSubviews() {
        addSubview(totalStackView)
        totalStackView.addArrangedSubview(emptyImage)
        totalStackView.addArrangedSubview(titleLabel)
        totalStackView.addArrangedSubview(descriptionLabel)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            totalStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            totalStackView.centerYAnchor.constraint(equalTo: centerYAnchor),

            emptyImage.heightAnchor.constraint(equalToConstant: 60),
            emptyImage.widthAnchor.constraint(equalToConstant: 60)
        ])
    }

    func setup(title: String, description: String, image: UIImage) {
        titleLabel.text = title
        descriptionLabel.text = description
        emptyImage.image = image
    }

    func show() {
        isHidden = false
    }

    func hide() {
        isHidden = true
    }
}
