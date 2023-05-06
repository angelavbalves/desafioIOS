//
//  PopularRepositoriesCell.swift
//  RepoPop
//
//  Created by Angela Alves on 25/07/22.
//

import Foundation
import UIKit
import Kingfisher

class PopularRepositoriesCell: UITableViewCell {

    // MARK: Properties
    static let identifer = "idCell"

    // MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        buildConstraintsCell()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Views
    private var totalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 16
        return stackView
    }()

    private var descriptionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
    }()

    private var personStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()

    private var infosStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 12

        return stackView
    }()

    private var iconForkStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal

        return stackView
    }()

    private var iconStarStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal

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
        label.numberOfLines = 5
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

    private var usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemBlue
        label.text = "username"
        label.textAlignment = .center

        return label
    }()

    private var forksLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .systemYellow
        label.textAlignment = .center

        return label
    }()

    private var starsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .systemYellow
        label.textAlignment = .center

        return label
    }()

    private var iconForks: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "tuningfork")

        return imageView
    }()

    private var iconStars: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "star.fill")

        return imageView
    }()

    // MARK: Aux
    func addViews() {
        contentView.addSubview(totalStackView)
        totalStackView.addArrangedSubview(descriptionStackView)
        totalStackView.addArrangedSubview(personStackView)
        descriptionStackView.addArrangedSubview(repositoryNameLabel)
        descriptionStackView.addArrangedSubview(descriptionLabel)
        descriptionStackView.addArrangedSubview(infosStackView)
        infosStackView.addArrangedSubview(iconForkStackView)
        infosStackView.addArrangedSubview(UIView())
        infosStackView.addArrangedSubview(iconStarStackView)
        iconForkStackView.addArrangedSubview(iconForks)
        iconForkStackView.addArrangedSubview(forksLabel)
        iconStarStackView.addArrangedSubview(iconStars)
        iconStarStackView.addArrangedSubview(starsLabel)
        personStackView.addArrangedSubview(userImageView)
        personStackView.addArrangedSubview(usernameLabel)
    }

    func buildConstraintsCell() {
        NSLayoutConstraint.activate([
            totalStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            totalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            totalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            totalStackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.layoutMarginsGuide.bottomAnchor, constant: -24),

            descriptionStackView.topAnchor.constraint(equalTo: totalStackView.topAnchor),
            descriptionStackView.leadingAnchor.constraint(equalTo: totalStackView.leadingAnchor),

            personStackView.trailingAnchor.constraint(equalTo: totalStackView.trailingAnchor),

            userImageView.widthAnchor.constraint(equalToConstant: 100),
            userImageView.heightAnchor.constraint(equalToConstant: 100),

            iconForks.widthAnchor.constraint(equalToConstant: 16),
            iconForks.heightAnchor.constraint(equalToConstant: 16),

            iconStars.widthAnchor.constraint(equalToConstant: 16),
            iconStars.heightAnchor.constraint(equalToConstant: 16)
        ])
    }

    func setup(for repository: RepositoryResponseItem) {
        usernameLabel.text = repository.owner.login
        descriptionLabel.text = repository.description
        guard let url = URL(string: repository.owner.avatarURL) else {
            return
        }
        userImageView.kf.indicatorType = .activity
        userImageView.kf.setImage(with: url,
                                  options: [.onFailureImage(UIImage(named: "errorImage"))]
        )
        repositoryNameLabel.text = repository.name
        forksLabel.text = String(repository.forks)
        starsLabel.text = String(repository.stargazersCount)
    }
}
