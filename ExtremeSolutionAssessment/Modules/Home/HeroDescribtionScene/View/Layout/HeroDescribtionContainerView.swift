//
//  HeroDescribtionContainerView.swift
//  ExtremeSolutionAssessment
//
//  Created by Karim on 13/10/2022.
//

import Foundation
import UIKit

class HeroDescribtionContainerView: UIView {
    
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
        return button
    }()
    
    lazy var heroImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
        image.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        image.image = #imageLiteral(resourceName: "mcu-background")
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
        label.text = "iron man"
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
        return label
    }()
    
    lazy var desc: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 10)
        label.numberOfLines = 0
        label.text = "jkahkljasldjgasjhdjkahkljasldjgasjhdjkahkljasldjgasjhdjkahkljasldjgasjhdjkahkljasldjgasjhdjkahkljasldjgasjhdjkahkljasldjgasjhdjkahkljasldjgasjhdjkahkljasldjgasjhdjkahkljasldjgasjhdjkahkljasldjgasjhdjkahkljasldjgasjhd"
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
    
    init() {
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
        setupBlur()
        setupScroll()
        setupScrollContainerView()
        setupHeroName()
        setupDescriptionStack()
        setupHeroShowsTableView()
    }
    
    private func addSubViews() {
        
        addSubview(blur)
        addSubview(heroImage)
        addSubview(backView)
        addSubview(scrollView)

        backView.addSubview(backBTN)
        
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
            blur.topAnchor.constraint(equalTo: self.topAnchor),
            blur.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            blur.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            blur.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func setupScroll() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: heroImage.bottomAnchor),
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
    
    private func setupHeroName() {
        NSLayoutConstraint.activate([
            heroName.topAnchor.constraint(equalTo: scrollContainerView.topAnchor, constant: 20),
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

    
}


extension HeroDescribtionContainerView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(HeroShowsTableViewCell.self), for: indexPath) as? HeroShowsTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        onTapRow?()
//        presenter.navigateToNextScene(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         150
    }
}
