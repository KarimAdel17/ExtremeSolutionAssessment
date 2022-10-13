//
//  SearchContainerView.swift
//  ExtremeSolutionAssessment
//
//  Created by Karim on 13/10/2022.
//

import Foundation
import UIKit

class SearchContainerView: UIView {
    
    lazy var blur: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurEffectView
    }()
    
    lazy var searchStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 20
        stack.alignment = .center
        stack.distribution = .fill
        return stack
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.tintColor = .white
        searchBar.barTintColor = #colorLiteral(red: 0.1764706075, green: 0.1764706075, blue: 0.1764706075, alpha: 1)
        searchBar.searchBarStyle = .default
        searchBar.backgroundImage = UIImage()
        searchBar.placeholder = "Search for a character..."
        if #available(iOS 13.0, *) {
            searchBar.searchTextField.textColor = .white
            searchBar.searchTextField.backgroundColor = #colorLiteral(red: 0.1764706075, green: 0.1764706075, blue: 0.1764706075, alpha: 1)
            searchBar.searchTextField.leftView?.tintColor = .white
            searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: searchBar.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        } else {
            // Fallback on earlier versions
        }
        searchBar.layer.cornerRadius = 20
        searchBar.clipsToBounds = true
        searchBar.heightAnchor.constraint(equalToConstant: 70).isActive = true
        return searchBar
    }()
    
    lazy var cancelBTN: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(#colorLiteral(red: 1, green: 0.5370028615, blue: 0.5585802197, alpha: 1), for: .normal)
        return button
    }()
    
    lazy var searchHerosTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(SearchHerosTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(SearchHerosTableViewCell.self))
        tableView.tableFooterView = UIView()
        tableView.layoutIfNeeded()
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
        setupBlur()
        setupSearchStack()
        setupHerosTableView()
    }
    
    private func addSubViews() {
        addSubview(blur)
        addSubview(searchStack)
        addSubview(searchHerosTableView)
        
        searchStack.addArrangedSubview(searchBar)
        searchStack.addArrangedSubview(cancelBTN)
    }
    
    private func setupBlur() {
        NSLayoutConstraint.activate([
            blur.topAnchor.constraint(equalTo: self.topAnchor),
            blur.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            blur.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            blur.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func setupSearchStack() {
        NSLayoutConstraint.activate([
//            searchStack.heightAnchor.constraint(equalToConstant: 70),
            searchStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 70),
            searchStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            searchStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
        ])
    }
    
    private func setupHerosTableView() {
        NSLayoutConstraint.activate([
            searchHerosTableView.topAnchor.constraint(equalTo: searchStack.bottomAnchor, constant: 25),
            searchHerosTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            searchHerosTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            searchHerosTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

extension SearchContainerView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(SearchHerosTableViewCell.self), for: indexPath) as? SearchHerosTableViewCell else {
            return UITableViewCell()
        }
        cell.heroImage.image = UIImage(named: "mcu-background")
        cell.heroName.text = "asdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasd"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        onTapRow?()
//        presenter.navigateToNextScene(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         100
    }
}
