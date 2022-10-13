//
//  SplashContainerView.swift
//  ExtremeSolutionAssessment
//
//  Created by Karim on 13/10/2022.
//

import Foundation
import UIKit

class SplashContainerView: UIView {
    
    lazy var backgroundImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "mcu-background")
        return image
    }()
    
    lazy var logoImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "marvel-logo")
        return image
    }()
    
    lazy var blur: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurEffectView
    }()
    
    init() {
        super.init(frame: .zero)
        layoutUserInterface()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutUserInterface() {
        addSubViews()
        setupBackgroundImage()
        setupBlur()
        setupLogoImage()
    }
    
    private func addSubViews() {
        addSubview(backgroundImage)
        addSubview(blur)
        addSubview(logoImage)
    }
    
    private func setupBackgroundImage() {
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            backgroundImage.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -100)
        ])
    }
    
    private func setupBlur() {
        NSLayoutConstraint.activate([
            blur.topAnchor.constraint(equalTo: self.topAnchor),
            blur.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            blur.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            blur.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func setupLogoImage() {
        NSLayoutConstraint.activate([
            logoImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            logoImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            logoImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            logoImage.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}
