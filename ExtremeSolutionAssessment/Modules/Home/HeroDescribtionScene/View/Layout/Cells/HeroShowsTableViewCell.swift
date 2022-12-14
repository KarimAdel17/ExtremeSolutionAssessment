//
//  HeroShowsTableViewCell.swift
//  ExtremeSolutionAssessment
//
//  Created by Karim on 13/10/2022.
//

import UIKit

class HeroShowsTableViewCell: UITableViewCell {

    var shows = [ItemsData]()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var showKind: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 1, green: 0.551985085, blue: 0.5694903135, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.text = "comics"
        return label
    }()
    
    lazy var showCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.itemSize = CGSize(width: 65, height: 120)
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        layout.minimumLineSpacing = 10
        
        collectionView.register(ShowCollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(ShowCollectionViewCell.self))
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
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
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0))
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
        setupShowKind()
        setupShowCollectionView()
    }

    private func addSubViews() {
        contentView.addSubview(containerView)
        containerView.addSubview(showKind)
        containerView.addSubview(showCollectionView)
    }

    private func setupContainerView() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }
    
    private func setupShowKind() {
        NSLayoutConstraint.activate([
            showKind.topAnchor.constraint(equalTo: containerView.topAnchor),
            showKind.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor)
        ])
    }
    
    private func setupShowCollectionView() {
        NSLayoutConstraint.activate([
            showCollectionView.topAnchor.constraint(equalTo: self.showKind.bottomAnchor, constant: 10),
            showCollectionView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor),
            showCollectionView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor),
            showCollectionView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor)
        ])
    }
}

extension HeroShowsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shows.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(ShowCollectionViewCell.self), for: indexPath) as? ShowCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.comicName.text = shows[indexPath.row].title
        if let path = shows[indexPath.row].thumbnail?.path, let imageExtension = shows[indexPath.row].thumbnail?.thumbnailExtension {
            let allPath = path + "." + imageExtension
            if let url = URL(string: allPath) {
                cell.comicImage.kf.indicatorType = .activity
                cell.comicImage.kf.setImage(with: url)
            }
        }
        
        return cell
    }
    
    
}
