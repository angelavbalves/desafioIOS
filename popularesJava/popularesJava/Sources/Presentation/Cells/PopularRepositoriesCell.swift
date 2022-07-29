//
//  PopularRepositoriesCell.swift
//  popularesJava
//
//  Created by Angela Alves on 25/07/22.
//

import Foundation
import UIKit

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

    private var stackViewInfos: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 12

        return stackView
    }()

    private var stackViewWithIconFork: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal

        return stackView
    }()

    private var stackViewWithIconStar: UIStackView = {
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

    private var labelForks: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .systemYellow
        label.textAlignment = .center

        return label
    }()

    private var labelStars: UILabel = {
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
        contentView.addSubview(stackViewTotal)
        stackViewTotal.addArrangedSubview(stackViewDescription)
        stackViewTotal.addArrangedSubview(stackViewPerson)
        stackViewDescription.addArrangedSubview(repositoryNameLabel)
        stackViewDescription.addArrangedSubview(descriptionLabel)
        stackViewDescription.addArrangedSubview(stackViewInfos)
        stackViewInfos.addArrangedSubview(stackViewWithIconFork)
        stackViewInfos.addArrangedSubview(UIView())
        stackViewInfos.addArrangedSubview(stackViewWithIconStar)
        stackViewWithIconFork.addArrangedSubview(iconForks)
        stackViewWithIconFork.addArrangedSubview(labelForks)
        stackViewWithIconStar.addArrangedSubview(iconStars)
        stackViewWithIconStar.addArrangedSubview(labelStars)
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

            stackViewInfos.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 6),

            stackViewPerson.trailingAnchor.constraint(equalTo: stackViewTotal.trailingAnchor, constant: 6),

            userImageView.widthAnchor.constraint(equalToConstant: 100),
            userImageView.heightAnchor.constraint(equalToConstant: 100),

            iconForks.widthAnchor.constraint(equalToConstant: 16),
            iconForks.heightAnchor.constraint(equalToConstant: 16),

            iconStars.widthAnchor.constraint(equalToConstant: 16),
            iconStars.heightAnchor.constraint(equalToConstant: 16)
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
        labelForks.text = String(repository.forks)
        labelStars.text = String(repository.stargazersCount)
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
