//
//  RPShadowView.swift
//  RepoPop
//
//  Created by Angela Alves on 08/03/23.
//

import Foundation
import UIKit

class RPShadowView: RPView {

    var cornerRadius: CGFloat = 15

    private lazy var darkShadow = CALayer() .. {
        $0.shadowOffset = CGSize(width: 10, height: 10)
        $0.shadowOpacity = 1
        $0.shadowRadius = 15
        $0.cornerRadius = cornerRadius
    }

    private lazy var lightShadow = CALayer() .. {
        $0.shadowOffset = CGSize(width: -5, height: -5)
        $0.shadowOpacity = 1
        $0.shadowRadius = 15
        $0.cornerRadius = cornerRadius
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        darkShadow.frame = self.bounds
        darkShadow.backgroundColor = AppColors.lightGray.cgColor
        darkShadow.shadowColor = AppColors.darkGray.withAlphaComponent(0.5).cgColor

        lightShadow.frame = self.bounds
        lightShadow.backgroundColor = AppColors.lightGray.cgColor
        lightShadow.shadowColor = UIColor.white.withAlphaComponent(0.9).cgColor
    }

    override func setupView() {
        backgroundColor = .lightGray
        layer.cornerRadius = cornerRadius
        layer.insertSublayer(darkShadow, at: 0)
        layer.insertSublayer(lightShadow, at: 0)
    }
}
