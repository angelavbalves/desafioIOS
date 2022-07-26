//
//  SearchView.swift
//  RepoPop
//
//  Created by Angela Alves on 09/08/22.
//

import Foundation
import UIKit

class SearchView: RPView {

    var didTapOnSearchButton: (_ language: String) -> Void

    init(didTapOnSearchButton: @escaping (_ language: String) -> Void) {
        self.didTapOnSearchButton = didTapOnSearchButton
        super.init()
        textField.delegate = self
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private var totalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 12

        return stackView
    }()

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 22)
        label.text = "Choose a language"

        return label
    }()

    private var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .whileEditing
        textField.placeholder = "Search for name"
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.contentVerticalAlignment = .center
        textField.keyboardType = .alphabet
        textField.returnKeyType = .done
        textField.textAlignment = .center

        return textField
    }()

    private var searchButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Search", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)

        return button
    }()

    private var emptyTextField: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 22)
        label.text = ""
        label.textColor = .systemRed

        return label
    }()

    override func configureSubviews() {
        addSubview(totalStackView)
        totalStackView.addArrangedSubview(titleLabel)
        totalStackView.addArrangedSubview(textField)
        totalStackView.addArrangedSubview(searchButton)
        totalStackView.addArrangedSubview(emptyTextField)
    }

    override func configureConstraints() {
        NSLayoutConstraint.activate([
            totalStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            totalStackView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    @objc func searchButtonTapped() {
        textField.resignFirstResponder()
        if let text = textField.text {
            if text != "" {
                didTapOnSearchButton(text)
                textField.text = ""
                emptyTextField.text = ""
                textField.layer.borderWidth = 0
            } else {
                textField.layer.borderColor = UIColor.systemRed.cgColor
                textField.layer.borderWidth = 2
                textField.layer.cornerRadius = 6
                emptyTextField.text = "The field can't be blank"
            }
        }
    }
}

extension SearchView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        searchButtonTapped()
        return true
    }
}
