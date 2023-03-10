//
//  SearchView.swift
//  RepoPop
//
//  Created by Angela Alves on 09/08/22.
//

import Foundation
import TinyConstraints
import UIKit

class SearchView: RPView {

    var didTapOnSearchButton: (_ language: String) -> Void
    private lazy var heightItem: CGFloat = self.frame.height * 0.4

    init(didTapOnSearchButton: @escaping (_ language: String) -> Void) {
        self.didTapOnSearchButton = didTapOnSearchButton
        super.init()
        textField.delegate = self
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let backgroundStackView = UIStackView() .. {
        $0.axis = .vertical
        $0.spacing = Spacing.cardSpace
        $0.alignment = .center
        $0.contentMode = .scaleAspectFit
    }

    private let logoImage = UIImageView() .. {
        $0.image = UIImage(named: "search")
        $0.contentMode = .scaleAspectFill
    }

    private lazy var card = RPShadowView()

    private var searchStackView = UIStackView() .. {
        $0.axis = .vertical
        $0.alignment = .center
        $0.spacing = Spacing.extraLarge
    }

    private var titleLabel = UILabel() .. {
        $0.font = Fonts.title
        $0.text = "Search for a language"
    }

    private let textField = UITextField() .. {
        $0.clearButtonMode = .whileEditing
        $0.placeholder = "Search for a language"
        $0.font = Fonts.subtitleLarge
        $0.contentVerticalAlignment = .center
        $0.keyboardType = .alphabet
        $0.returnKeyType = .done
        $0.textAlignment = .center
        $0.backgroundColor = AppColors.lightGray
        $0.layer.shadowColor = AppColors.darkGray.cgColor
        $0.layer.borderColor = AppColors.lightGray.cgColor
        $0.layer.shadowOffset = CGSize(width: 0.75, height: 0.75)
        $0.layer.cornerRadius = 8
        $0.layer.shadowOpacity = 0.4
        $0.layer.shadowRadius = 20.0
        $0.height(60)

    }
    
    private lazy var searchButton = RPButton() .. {
        $0.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
    }

    override func configureSubviews() {
        addSubview(backgroundStackView)
        backgroundStackView.addArrangedSubview(logoImage)
        backgroundStackView.addArrangedSubview(card)
        card.addSubview(searchStackView)
        searchStackView.addArrangedSubview(textField)
        searchStackView.addArrangedSubview(searchButton)
    }

    override func configureConstraints() {
        backgroundStackView.centerInSuperview(usingSafeArea: true)
        logoImage.height(to: backgroundStackView, multiplier: 0.4)
        logoImage.width(to: backgroundStackView)
        card.height(to: backgroundStackView, multiplier: 0.52)
        card.width(to: backgroundStackView, multiplier: 0.5)
        searchStackView.center(in: card)
        searchButton.width(to: card, multiplier: 0.4)
        textField.width(to: card, multiplier: 0.8)

    }

    @objc func searchButtonTapped() {
        textField.resignFirstResponder()
        if let text = textField.text {
            if text != "" {
                didTapOnSearchButton(text)
                textField.text = ""
                textField.layer.borderWidth = 0
            } else {
                textField.layer.borderColor = UIColor.systemRed.cgColor
                textField.layer.borderWidth = 2
                textField.layer.cornerRadius = 6
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
