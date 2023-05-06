//
//  PopularRepositoriesCell.swift
//  RepoPop
//
//  Created by Angela Alves on 25/07/22.
//

import Foundation
import UIKit
import TinyConstraints
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
    private let cardCell = RPShadowView()

    private let stackView = UIStackView() .. {
        $0.axis = .horizontal
        $0.spacing = Spacing.large
        $0.alignment = .center
        $0.distribution = .fillProportionally
    }

    private var leftStackView = UIStackView() .. {
        $0.axis = .vertical
        $0.spacing = Spacing.medium
    }

    private var rightStackView = UIStackView() .. {
        $0.axis = .vertical
        $0.spacing = Spacing.extraSmall
    }

    private var rowStackView = UIStackView() .. {
        $0.axis = .horizontal
        $0.spacing = Spacing.medium
        $0.distribution = .equalSpacing
    }

    private var repositoryNameLabel = UILabel() .. {
        $0.numberOfLines = 0
        $0.font = UIFont.systemFont(ofSize: 24)
        $0.textColor = AppColors.darkGray
        $0.setContentHuggingPriority(.required, for: .vertical)
    }

    private let descriptionLabel = UILabel() .. {
        $0.numberOfLines = 5
        $0.font = Fonts.subtitleLarge
        $0.textColor = .black
        $0.textAlignment = .justified
    }

    private lazy var userImageView = UIImageView() .. {
        $0.layer.cornerRadius = 30
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
        $0.width(60)
        $0.height(60)
    }

    private let usernameLabel = UILabel() .. {
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = AppColors.darkGray
        $0.textAlignment = .center
    }

    private lazy var forks = RPDetailsRow() .. {
        $0.iconRow.image = UIImage(systemName: "arrow.triangle.branch")?.withTintColor(AppColors.green, renderingMode: .alwaysOriginal)
    }

    private lazy var stars = RPDetailsRow() .. {
        $0.iconRow.image = UIImage(systemName: "star.fill")?.withTintColor(AppColors.yellow, renderingMode: .alwaysOriginal)
    }

    // MARK: Aux
    func addViews() {
        addSubview(cardCell)
        cardCell.addSubview(stackView)
        stackView.addArrangedSubview(leftStackView)
        stackView.addArrangedSubview(rightStackView)
        leftStackView.addArrangedSubview(repositoryNameLabel)
        leftStackView.addArrangedSubview(descriptionLabel)
        leftStackView.addArrangedSubview(rowStackView)
        rightStackView.addArrangedSubview(userImageView)
        rightStackView.addArrangedSubview(usernameLabel)
        rowStackView.addArrangedSubview(forks)
        rowStackView.addArrangedSubview(stars)
    }

    func buildConstraintsCell() {
        cardCell.edgesToSuperview(insets: .uniform(Spacing.medium), usingSafeArea: true)
        stackView.edges(to: cardCell, insets: .uniform(Spacing.medium))
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
        forks.info.text = String(repository.forks)
        stars.info.text = String(repository.stargazersCount)
    }
}
