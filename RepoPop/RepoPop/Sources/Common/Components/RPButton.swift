//
//  RPButton.swift
//  RepoPop
//
//  Created by Angela Alves on 08/03/23.
//

import Foundation
import TinyConstraints
import UIKit

class RPButton: UIButton {

    private let propertyAnimator = UIViewPropertyAnimator(duration: 0.2, curve: .easeOut)

    override var isHighlighted: Bool {
        didSet {
            setBackgroundColor()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        self.setHugging(.required, for: .vertical)
        self.tintColor = .black
        self.setTitle("Search", for: .normal)
        self.setTitleColor(.black, for: .normal)
        let image = UIImage(systemName: "magnifyingglass")
        self.setImage(image, for: .normal)
        self.backgroundColor = AppColors.green
        self.layer.opacity = 0.8
        self.height(32)
        self.layer.cornerRadius = 16.0
        self.clipsToBounds = true
    }

    func setBackgroundColor() {
        if self.isHighlighted {
            self.propertyAnimator.stopAnimation(true)
            backgroundColor = AppColors.lightGreen
            return
        }
        self.propertyAnimator.addAnimations {
            self.backgroundColor = AppColors.green
        }
        self.propertyAnimator.startAnimation()
    }
}
