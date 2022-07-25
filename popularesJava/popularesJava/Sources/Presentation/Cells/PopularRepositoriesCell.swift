//
//  PopularRepositoriesCell.swift
//  popularesJava
//
//  Created by Angela Alves on 25/07/22.
//

import Foundation
import UIKit

class PopularRepositoriesCell: UITableViewCell {

    static let identifer = "idCell"

    private var stackViewTotal: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 12
        return stackView
    }()

    private var stackViewDescription: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
    }()

    private var stackViewPerson: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()

    private var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Repository name"
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = .black

        return label
    }()

    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit."
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.textAlignment = .justified

        return label
    }()

    private lazy var userImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .red
        image.layer.cornerRadius = 50
        image.clipsToBounds = true

        return image
    }()

    private var username: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .blue
        label.text = "username"
        label.textAlignment = .center

        return label
    }()


    private var nameUserLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemGray
        label.text = "Nome sobrenome"
        label.numberOfLines = 0
        label.textAlignment = .center


        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        buildConstraintsCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func addViews() {
        contentView.addSubview(stackViewTotal)
        stackViewTotal.addArrangedSubview(stackViewDescription)
        stackViewTotal.addArrangedSubview(stackViewPerson)
        stackViewDescription.addArrangedSubview(nameLabel)
        stackViewDescription.addArrangedSubview(descriptionLabel)
        stackViewPerson.addArrangedSubview(userImageView)
        stackViewPerson.addArrangedSubview(username)
        stackViewPerson.addArrangedSubview(nameUserLabel)

    }

    func buildConstraintsCell() {
        NSLayoutConstraint.activate([
            stackViewTotal.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 24),
            stackViewTotal.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 24),
            stackViewTotal.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -24),
            stackViewTotal.bottomAnchor.constraint(lessThanOrEqualTo: contentView.layoutMarginsGuide.bottomAnchor, constant: -24),

            stackViewDescription.topAnchor.constraint(equalTo: stackViewTotal.topAnchor, constant: 6),
            stackViewDescription.leadingAnchor.constraint(equalTo: stackViewTotal.leadingAnchor, constant: 6),

            stackViewPerson.trailingAnchor.constraint(equalTo: stackViewTotal.trailingAnchor, constant: 6),
            userImageView.widthAnchor.constraint(equalToConstant: 100),
            userImageView.heightAnchor.constraint(equalToConstant: 100),

            
        ])

    }

}
