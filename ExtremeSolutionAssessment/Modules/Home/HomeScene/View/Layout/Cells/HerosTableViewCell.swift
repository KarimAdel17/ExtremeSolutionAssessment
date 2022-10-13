//
//  HerosTableViewCell.swift
//  ExtremeSolutionAssessment
//
//  Created by Karim on 13/10/2022.
//

import UIKit

class HerosTableViewCell: UITableViewCell {

    lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.layer.cornerRadius = 30
        return view
    }()
    
    lazy var heroImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 30
        image.clipsToBounds = true
        return image
    }()
    
    lazy var heroName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    let blur: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.systemThinMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.9
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.layer.cornerRadius = 30
        blurEffectView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        blurEffectView.clipsToBounds = true
        return blurEffectView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 18, right: 0))
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        layoutUserInterFace()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutUserInterFace() {
        addSubViews()
        setupContainerView()
        setupHeroImage()
        setupHeroName()
        setupBlur()
    }

    private func addSubViews() {
        contentView.addSubview(containerView)
        containerView.addSubview(heroImage)
        containerView.addSubview(blur)
        
        blur.contentView.addSubview(heroName)
    }
    
    private func setupContainerView() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }
    
    private func setupHeroImage() {
        NSLayoutConstraint.activate([
            heroImage.topAnchor.constraint(equalTo: self.containerView.topAnchor),
            heroImage.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor),
            heroImage.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor),
            heroImage.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor)
        ])
    }
    
    private func setupBlur() {
        NSLayoutConstraint.activate([
            heroName.heightAnchor.constraint(equalToConstant: 40),
            blur.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor),
            blur.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor),
            blur.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor)
        ])
    }
    
    private func setupHeroName() {
        NSLayoutConstraint.activate([
            heroName.topAnchor.constraint(equalTo: blur.topAnchor),
            heroName.leadingAnchor.constraint(equalTo: self.blur.leadingAnchor),
            heroName.trailingAnchor.constraint(equalTo: self.blur.trailingAnchor),
            heroName.bottomAnchor.constraint(equalTo: self.blur.bottomAnchor)
        ])
    }
}
