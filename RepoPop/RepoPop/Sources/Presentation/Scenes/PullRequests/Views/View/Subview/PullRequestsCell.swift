//
//  PullRequestsCell.swift
//  RepoPop
//
//  Created by Angela Alves on 27/07/22.
//

import Foundation
import UIKit
import Kingfisher
import TinyConstraints

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
    private let cardRow = RPShadowView()

    private let backgroundStackView = UIStackView() .. {
        $0.axis = .vertical
        $0.spacing = Spacing.medium
    }

    private let title = UILabel() .. {
        $0.numberOfLines = 0
        $0.font = UIFont.systemFont(ofSize: 18)
        $0.textColor = .black
        $0.textAlignment = .justified
    }

    private let descriptionLabel = UILabel() .. {
        $0.numberOfLines = 4
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = .black
        $0.textAlignment = .justified
    }

    private let userStackView = UIStackView() .. {
        $0.axis = .horizontal
        $0.spacing = Spacing.extraSmall
        $0.alignment = .center
    }

    private let infoStackView = UIStackView() .. {
        $0.axis = .vertical
    }

    private let userImageView = UIImageView() .. {
        $0.layer.cornerRadius = 30
        $0.clipsToBounds = true
        $0.width(60)
        $0.height(60)
        $0.contentMode = .scaleAspectFill
    }

    private let username = UILabel() .. {
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = .systemBlue
    }

    private let dateUpdateLabel = UILabel() .. {
        $0.font = Fonts.text
        $0.textColor = .systemGray
    }

    // MARK: Aux
    func setupSubViews() {
        addSubview(cardRow)
        cardRow.addSubview(backgroundStackView)
        backgroundStackView.addArrangedSubview(title)
        backgroundStackView.addArrangedSubview(descriptionLabel)
        backgroundStackView.addArrangedSubview(userStackView)
        userStackView.addArrangedSubview(userImageView)
        userStackView.addArrangedSubview(infoStackView)
        infoStackView.addArrangedSubview(username)
        infoStackView.addArrangedSubview(dateUpdateLabel)
    }

    func buildConstraints() {
        cardRow.edgesToSuperview(insets: .uniform(Spacing.medium), usingSafeArea: true)
        backgroundStackView.edges(to: cardRow, insets: .uniform(Spacing.medium))
    }

    func setup(for pullRequest: PullRequestResponseItem) {
        title.text = pullRequest.title
        username.text = pullRequest.user.login
        descriptionLabel.text = pullRequest.body
        guard let url = URL(string: pullRequest.user.avatar_url) else {
            return
        }
        userImageView.kf.indicatorType = .activity
        userImageView.kf.setImage(with: url,
                                  options: [.onFailureImage(UIImage(named: "errorImage"))]
        )
        dateUpdateLabel.text = pullRequest.updated_at
    }
}
