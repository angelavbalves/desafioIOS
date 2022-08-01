//
//  PullRequestsCell.swift
//  popularesJava
//
//  Created by Angela Alves on 27/07/22.
//

import Foundation
import UIKit

class PullRequestsCell: UITableViewCell {

    // MARK: Properties
    static let identifer = "idCell"

    // MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubViews()
        buildConstraints()
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

        return stackView
    }()

    private var titlePullRequestLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
        label.textAlignment = .justified

        return label
    }()

    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 4
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.textAlignment = .justified

        return label
    }()

    private var userStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .center

        return stackView
    }()

    private var DataStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical

        return stackView
    }()

    private var userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true

        return imageView
    }()

    private var usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemBlue
        label.text = "username"

        return label
    }()

    private var dateUpdateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .systemGray
        label.text = "Date update"

        return label
    }()

    // MARK: Aux
    func setupSubViews() {
        contentView.addSubview(totalStackView)
        totalStackView.addArrangedSubview(titlePullRequestLabel)
        totalStackView.addArrangedSubview(descriptionLabel)
        totalStackView.addArrangedSubview(userStackView)
        userStackView.addArrangedSubview(userImageView)
        userStackView.addArrangedSubview(DataStackView)
        DataStackView.addArrangedSubview(usernameLabel)
        DataStackView.addArrangedSubview(dateUpdateLabel)
        DataStackView.addArrangedSubview(UIView())
    }

    func buildConstraints() {
        NSLayoutConstraint.activate([
            totalStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            totalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            totalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            totalStackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.layoutMarginsGuide.bottomAnchor, constant: -24),

            userStackView.bottomAnchor.constraint(equalTo: totalStackView.bottomAnchor),

            userImageView.widthAnchor.constraint(equalToConstant: 60),
            userImageView.heightAnchor.constraint(equalToConstant: 60),

        ])
    }

    func setup(for pullRequest: PullRequestResponseItem) {
        titlePullRequestLabel.text = pullRequest.title
        usernameLabel.text = pullRequest.user.login
        descriptionLabel.text = pullRequest.body
        guard let url = URL(string: pullRequest.user.avatar_url) else {
            return
        }
        userImageView.downloadImage(from: url)
        dateUpdateLabel.text = pullRequest.updated_at
    }
}
