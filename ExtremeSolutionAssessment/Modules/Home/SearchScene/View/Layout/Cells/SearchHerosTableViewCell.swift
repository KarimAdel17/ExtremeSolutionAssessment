//
//  SearchHerosTableViewCell.swift
//  ExtremeSolutionAssessment
//
//  Created by Karim on 13/10/2022.
//

import UIKit

class SearchHerosTableViewCell: UITableViewCell {

    lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.1764706075, green: 0.1764706075, blue: 0.1764706075, alpha: 1)
        view.layer.cornerRadius = 15
        return view
    }()
    
    lazy var heroImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 15
        image.clipsToBounds = true
        image.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        return image
    }()
    
    lazy var heroName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.numberOfLines = 2
        return label
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
    }

    private func addSubViews() {
        contentView.addSubview(containerView)
        containerView.addSubview(heroImage)
        containerView.addSubview(heroName)
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
            heroImage.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor),
            heroImage.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setupHeroName() {
        NSLayoutConstraint.activate([
            heroName.centerYAnchor.constraint(equalTo: self.containerView.centerYAnchor),
            heroName.leadingAnchor.constraint(equalTo: self.heroImage.trailingAnchor, constant: 20),
            heroName.trailingAnchor.constraint(lessThanOrEqualTo: self.containerView.trailingAnchor, constant: -20),
        ])
    }
}
