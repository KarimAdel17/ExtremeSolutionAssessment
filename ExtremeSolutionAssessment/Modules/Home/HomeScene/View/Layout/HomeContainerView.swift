//
//  HomeContainerView.swift
//  ExtremeSolutionAssessment
//
//  Created by Karim on 13/10/2022.
//

import Foundation
import UIKit

class HomeContainerView: UIView {
    
    let viewModel: HomeViewModel!
    
    lazy var searchView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.1058823541, green: 0.1058823541, blue: 0.1058823541, alpha: 1)
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return view
    }()
    
    lazy var logoImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "marvel-logo")
        return image
    }()
    
    lazy var searchBTN: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = #colorLiteral(red: 0.9457526803, green: 0.07907819003, blue: 0.1172275469, alpha: 1)
        button.setImage(UIImage(named: "ic-magnifying-glass"), for: .normal)
        button.addTarget(self, action: #selector(didTappedSearch), for: .touchUpInside)
        return button
    }()
    
    lazy var herosTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(HerosTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(HerosTableViewCell.self))
        tableView.tableFooterView = UIView()
        tableView.layoutIfNeeded()
        tableView.isScrollEnabled = true
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        self.backgroundColor = #colorLiteral(red: 0.08235292882, green: 0.08235292882, blue: 0.08235292882, alpha: 1)
        layoutUserInterface()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutUserInterface() {
        addSubViews()
        setupSearchView()
        setupHerosTableView()
        setupLogoImage()
        setupSearchBTN()
    }
    
    private func addSubViews() {
        addSubview(searchView)
        addSubview(herosTableView)
        
        searchView.addSubview(logoImage)
        searchView.addSubview(searchBTN)
    }
    
    private func setupSearchView() {
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: self.topAnchor),
            searchView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            searchView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            searchView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func setupHerosTableView() {
        NSLayoutConstraint.activate([
            herosTableView.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 15),
            herosTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            herosTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            herosTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func setupLogoImage() {
        NSLayoutConstraint.activate([
            logoImage.centerYAnchor.constraint(equalTo: searchView.centerYAnchor, constant: 25),
            logoImage.centerXAnchor.constraint(equalTo: searchView.centerXAnchor),
            logoImage.heightAnchor.constraint(equalToConstant: 100),
            logoImage.widthAnchor.constraint(equalToConstant: 190)
        ])
    }
    
    private func setupSearchBTN() {
        NSLayoutConstraint.activate([
            searchBTN.centerYAnchor.constraint(equalTo: logoImage.centerYAnchor),
            searchBTN.trailingAnchor.constraint(equalTo: searchView.trailingAnchor, constant: -30),
            searchBTN.heightAnchor.constraint(equalToConstant: 20),
            searchBTN.widthAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    var onTapSearch: (() -> Void)?
    var onTapCell: ((_ index: Int) -> Void)?
    var Pagination: (() -> Void)?
    
    @objc func didTappedSearch() {
        onTapSearch?()
    }
    
    func bind(_ hero: HerosData, with cell: HerosTableViewCell) -> HerosTableViewCell {
//        cell.apply {
        
        cell.heroName.text = hero.name
        
        if let path = hero.thumbnail?.path, let imageExtension = hero.thumbnail?.thumbnailExtension {
            let allPath = path + "." + imageExtension
            if let url = URL(string: allPath) {
                cell.heroImage.kf.indicatorType = .activity
                cell.heroImage.kf.setImage(with: url)
            }
        }
        return cell
    }
}

extension HomeContainerView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getHerosCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(HerosTableViewCell.self), for: indexPath) as? HerosTableViewCell else {
            return HerosTableViewCell()
        }

        guard indexPath.row < viewModel.getHerosCount() else {
            return cell
        }

        let hero = viewModel.getHero(index: indexPath.row)
        return bind(hero, with: cell)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        delegate?.HomeViewController(self, didSelectHero: viewModel.getHero(index: indexPath.row))
        
        onTapCell?(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         200
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (viewModel.getHerosCount() - 3) {
            if viewModel.getTotal() > viewModel.getCurrent() {
                Pagination?()
//                viewModel.refresh()
            }
        }
    }
}

