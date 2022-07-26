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
        stackView.spacing = 16
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

    private var stackViewIcons: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 12

        return stackView
    }()

    private var repositoryNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Repository name"
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = .systemBlue
        label.setContentHuggingPriority(.required, for: .vertical)

        return label
    }()

    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
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
        label.textColor = .systemBlue
        label.text = "username"
        label.textAlignment = .center

        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        buildConstraintsCell()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addViews() {
        contentView.addSubview(stackViewTotal)
        stackViewTotal.addArrangedSubview(stackViewDescription)
        stackViewTotal.addArrangedSubview(stackViewPerson)
        stackViewDescription.addArrangedSubview(repositoryNameLabel)
        stackViewDescription.addArrangedSubview(descriptionLabel)
        stackViewDescription.addArrangedSubview(UIView())
        stackViewPerson.addArrangedSubview(userImageView)
        stackViewPerson.addArrangedSubview(username)
    }

    func buildConstraintsCell() {
        NSLayoutConstraint.activate([
            stackViewTotal.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            stackViewTotal.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            stackViewTotal.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            stackViewTotal.bottomAnchor.constraint(lessThanOrEqualTo: contentView.layoutMarginsGuide.bottomAnchor, constant: -24),

            stackViewDescription.topAnchor.constraint(equalTo: stackViewTotal.topAnchor, constant: 6),
            stackViewDescription.leadingAnchor.constraint(equalTo: stackViewTotal.leadingAnchor, constant: 6),

            stackViewPerson.trailingAnchor.constraint(equalTo: stackViewTotal.trailingAnchor, constant: 6),

            userImageView.widthAnchor.constraint(equalToConstant: 100),
            userImageView.heightAnchor.constraint(equalToConstant: 100),

        ])
    }

    func setup(for repository: RepositoryResponseItem) {
        username.text = repository.owner.login
        descriptionLabel.text = repository.description
        guard let url = URL(string: repository.owner.avatarURL) else {
            return
        }
        userImageView.downloadImage(from: url)
        repositoryNameLabel.text = repository.name
    }
}

extension UIImageView {
    func downloadImage(from url: URL) {
        let session = URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data {
                let image = UIImage(data: data)
                DispatchQueue.main.async { [weak self] in
                    self?.image = image
                }
            }
        }
        session.resume()
    }
}
