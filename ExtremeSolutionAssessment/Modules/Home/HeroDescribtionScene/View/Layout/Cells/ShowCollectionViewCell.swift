//
//  ShowCollectionViewCell.swift
//  ExtremeSolutionAssessment
//
//  Created by Karim on 13/10/2022.
//

import UIKit

class ShowCollectionViewCell: UICollectionViewCell {
    
    
    lazy var comicImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 5
        image.clipsToBounds = true
        image.image = #imageLiteral(resourceName: "image-placeholder")
        return image
    }()
    
    lazy var comicName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 6)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        layoutUserInterFace()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutUserInterFace() {
        addSubViews()
        setupComicImage()
        setupComicName()
    }
    
    private func addSubViews() {
        contentView.addSubview(comicImage)
        contentView.addSubview(comicName)
        
    }
    
    private func setupComicImage() {
        NSLayoutConstraint.activate([
            comicImage.topAnchor.constraint(equalTo: self.topAnchor),
            comicImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            comicImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            comicImage.heightAnchor.constraint(equalToConstant: 90)
        ])
    }
    
    private func setupComicName() {
        NSLayoutConstraint.activate([
            comicName.topAnchor.constraint(equalTo: comicImage.bottomAnchor, constant: 6),
            comicName.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -3),
            comicName.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            comicName.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}
