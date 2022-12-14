//
//  HeroDescribtionContainerView.swift
//  ExtremeSolutionAssessment
//
//  Created by Karim on 13/10/2022.
//

import Foundation
import UIKit

class HeroDescribtionContainerView: UIView {
    
    let viewModel: HeroDescriptionViewModel!
    let disposeBag = DisposeBag()
    
    lazy var backView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.1595962346, green: 0.3037308156, blue: 0.3968305886, alpha: 1)
        view.layer.cornerRadius = 15
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        return view
    }()
    
    lazy var backBTN: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.setImage(UIImage(named: "ic-back"), for: .normal)
        button.addTarget(self, action: #selector(didTappedBackBTN), for: .touchUpInside)
        return button
    }()
    
    lazy var heroImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
        image.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return image
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .clear
        return scrollView
    }()
    
    lazy var scrollContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var backgroundImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var blur: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurEffectView
    }()
    
    lazy var heroName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()
    
    lazy var descriptionStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 5
        stack.alignment = .leading
        stack.distribution = .fill
        return stack
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 1, green: 0.551985085, blue: 0.5694903135, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.text = "Description"
        label.isHidden = true
        return label
    }()
    
    lazy var desc: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 10)
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    
    lazy var heroShowsTableView: ContentSizedTableView = {
        let tableView = ContentSizedTableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(HeroShowsTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(HeroShowsTableViewCell.self))
        tableView.tableFooterView = UIView()
        tableView.isScrollEnabled = true
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    init(viewModel: HeroDescriptionViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        layoutUserInterface()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutUserInterface() {
        addSubViews()
        setupHeroImage()
        setupBackView()
        setupBackBTN()
        setupBackgroundImage()
        setupBlur()
        setupScroll()
        setupScrollContainerView()
        setupHeroName()
        setupDescriptionStack()
        setupHeroShowsTableView()
    }
    
    private func addSubViews() {
        
        addSubview(backgroundImage)
        addSubview(blur)
        addSubview(scrollView)
        addSubview(heroImage)
        addSubview(backView)
        
        backView.addSubview(backBTN)
        
//        scrollView.addSubview(backgroundImage)
//        scrollView.addSubview(blur)
        scrollView.addSubview(scrollContainerView)
        
        scrollContainerView.addSubview(heroName)
        scrollContainerView.addSubview(descriptionStack)
        scrollContainerView.addSubview(heroShowsTableView)
        
        descriptionStack.addArrangedSubview(descriptionLabel)
        descriptionStack.addArrangedSubview(desc)
    }
    
    private func setupHeroImage() {
        NSLayoutConstraint.activate([
            heroImage.topAnchor.constraint(equalTo: self.topAnchor),
            heroImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            heroImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            heroImage.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func setupBackView() {
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: self.topAnchor, constant: 40),
            backView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backView.heightAnchor.constraint(equalToConstant: 30),
            backView.widthAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    private func setupBackBTN() {
        NSLayoutConstraint.activate([
            backBTN.centerYAnchor.constraint(equalTo: backView.centerYAnchor),
            backBTN.centerXAnchor.constraint(equalTo: backView.centerXAnchor, constant: -2),
            backBTN.heightAnchor.constraint(equalToConstant: 15),
            backBTN.widthAnchor.constraint(equalToConstant: 15)
        ])
    }
    
    private func setupBlur() {
        NSLayoutConstraint.activate([
            blur.topAnchor.constraint(equalTo: heroImage.bottomAnchor, constant: -20),
            blur.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            blur.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//            blur.heightAnchor.constraint(equalToConstant: ((UIScreen.main.preferredMode?.size.height)!) - 200)
            blur.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func setupScroll() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: heroImage.bottomAnchor, constant: -15),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    private func setupScrollContainerView() {
        NSLayoutConstraint.activate([
            scrollContainerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollContainerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollContainerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollContainerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollContainerView.widthAnchor.constraint(equalTo: self.widthAnchor),
            scrollContainerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 200)
        ])
    }
    
    private func setupBackgroundImage() {
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: heroImage.bottomAnchor, constant: -20),
            backgroundImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: self.trailingAnchor)
//            backgroundImage.heightAnchor.constraint(equalToConstant: ((UIScreen.main.preferredMode?.size.height)!) - 200),
//            backgroundImage.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    private func setupHeroName() {
        NSLayoutConstraint.activate([
            heroName.topAnchor.constraint(equalTo: scrollContainerView.topAnchor, constant: 35),
            heroName.leadingAnchor.constraint(equalTo: scrollContainerView.leadingAnchor, constant: 15),
            heroName.trailingAnchor.constraint(equalTo: scrollContainerView.trailingAnchor, constant: -15)
        ])
    }
    
    private func setupDescriptionStack() {
        NSLayoutConstraint.activate([
            descriptionStack.topAnchor.constraint(equalTo: heroName.bottomAnchor, constant: 25),
            descriptionStack.leadingAnchor.constraint(equalTo: scrollContainerView.leadingAnchor, constant: 15),
            descriptionStack.trailingAnchor.constraint(equalTo: scrollContainerView.trailingAnchor, constant: -15)
        ])
    }
    
    private func setupHeroShowsTableView() {
        NSLayoutConstraint.activate([
            heroShowsTableView.topAnchor.constraint(equalTo: descriptionStack.bottomAnchor, constant: 20),
            heroShowsTableView.leadingAnchor.constraint(equalTo: descriptionStack.leadingAnchor),
            heroShowsTableView.trailingAnchor.constraint(equalTo: descriptionStack.trailingAnchor),
            heroShowsTableView.bottomAnchor.constraint(equalTo: scrollContainerView.bottomAnchor),
        ])
    }
    
    var onTapBackBTN: (() -> Void)?
    
    @objc func didTappedBackBTN() {
        onTapBackBTN?()
    }
    
    func bind(_ show: HeroShows, with cell: HeroShowsTableViewCell) -> HeroShowsTableViewCell {
        cell.apply { [weak self] _ in
            guard let self = self else { return }
            cell.showKind.text = show.showKind
            
            DispatchQueue.global().async {
                self.viewModel.items({ [weak self] result in
                    guard let self = self else { return }
                    switch result {
                    case .success:
                        cell.shows = self.viewModel.getItems()
                        self.apply(onMainThread: true) {_ in
                            cell.showCollectionView.reloadData()
                        }
                    case let .failure(error):
                        print(error)
                    }
                }, url: show.show?.collectionURI ?? "").disposed(by: self.disposeBag)
                
            }
        }
        return cell
    }
}
