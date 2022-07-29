//
//  PullsRequestCell.swift
//  popularesJava
//
//  Created by Angela Alves on 27/07/22.
//

import Foundation
import UIKit

class PullsRequestCell: UITableViewCell {

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
    private var stackViewTotal: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 6

        return stackView
    }()

    private var titlePullRequest: UILabel = {
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

    private var stackViewUser: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .center

        return stackView
    }()

    private var stackViewData: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical

        return stackView
    }()

    private var userImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true

        return imageView
    }()

    private var username: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemBlue
        label.text = "username"

        return label
    }()

    private var dateUpdate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .systemGray
        label.text = "Date update"

        return label
    }()

    // MARK: Aux
    func setupSubViews() {
        contentView.addSubview(stackViewTotal)
        stackViewTotal.addArrangedSubview(titlePullRequest)
        stackViewTotal.addArrangedSubview(descriptionLabel)
        stackViewTotal.addArrangedSubview(stackViewUser)
        stackViewUser.addArrangedSubview(userImage)
        stackViewUser.addArrangedSubview(stackViewData)
        stackViewData.addArrangedSubview(username)
        stackViewData.addArrangedSubview(dateUpdate)
        stackViewData.addArrangedSubview(UIView())
    }

    func buildConstraints() {
        NSLayoutConstraint.activate([
            stackViewTotal.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            stackViewTotal.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            stackViewTotal.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            stackViewTotal.bottomAnchor.constraint(lessThanOrEqualTo: contentView.layoutMarginsGuide.bottomAnchor, constant: -24),

            stackViewUser.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 24),
            userImage.widthAnchor.constraint(equalToConstant: 60),
            userImage.heightAnchor.constraint(equalToConstant: 60),

        ])
    }

    func setup(for pullRequest: PullRequestResponseItem) {
        titlePullRequest.text = pullRequest.title
        username.text = pullRequest.user.login
        descriptionLabel.text = pullRequest.body
        guard let url = URL(string: pullRequest.user.avatar_url) else {
            return
        }
        userImage.downloadImage(from: url)
        dateUpdate.text = pullRequest.updated_at
    }
}
