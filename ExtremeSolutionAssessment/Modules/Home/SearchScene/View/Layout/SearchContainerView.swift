//
//  SearchContainerView.swift
//  ExtremeSolutionAssessment
//
//  Created by Karim on 13/10/2022.
//

import Foundation
import UIKit

class SearchContainerView: UIView {
    
    let viewModel: SearchViewModel!
    var timer: Timer?
    
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
        searchBar.searchTextField.delegate = self
        searchBar.searchTextField.becomeFirstResponder()
        return searchBar
    }()
    
    lazy var cancelBTN: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(#colorLiteral(red: 1, green: 0.5370028615, blue: 0.5585802197, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(didTappedCancel), for: .touchUpInside)
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
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
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
    
    var onTapSearch: ((_ searchText: String) -> Void)?
    var onTapCancel: (() -> Void)?
    var onTapCell: ((_ index: Int) -> Void)?
    var Pagination: ((_ searchText: String) -> Void)?
    
    @objc func didTappedSearch() {
        if let searchText = searchBar.searchTextField.text, !searchText.isEmpty {
            onTapSearch?(searchText)
        } else {
            searchHerosTableView.reloadData()
        }
    }
    
    @objc func didTappedCancel() {
        onTapCancel?()
    }
    
    func bind(_ hero: HerosData, with cell: SearchHerosTableViewCell) -> SearchHerosTableViewCell {
        cell.apply { _ in
            
            let attrStr = NSMutableAttributedString(string: hero.name ?? "")
            let inputLength = attrStr.string.count
            if let searchString = self.searchBar.searchTextField.text {
                let searchLength = searchString.count
                var range = NSRange(location: 0, length: attrStr.length)
                
                while (range.location != NSNotFound) {
                    range = (attrStr.string.lowercased() as NSString).range(of: searchString.lowercased(), options: [], range: range)
                    if (range.location != NSNotFound) {
                        attrStr.addAttribute(NSAttributedString.Key.backgroundColor, value:  UIColor.red.withAlphaComponent(0.5), range: NSRange(location: range.location, length: searchLength))
                        range = NSRange(location: range.location + range.length, length: inputLength - (range.location + range.length))
                        cell.heroName.attributedText = attrStr
                    }
                }
            }
            
            if let path = hero.thumbnail?.path, let imageExtension = hero.thumbnail?.thumbnailExtension {
                let allPath = path + "." + imageExtension
                if let url = URL(string: allPath) {
                    cell.heroImage.kf.indicatorType = .activity
                    cell.heroImage.kf.setImage(with: url)
                }
            }
        }
        return cell
    }
}

extension SearchContainerView: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.didTappedSearch), userInfo: nil, repeats: false);
        
        return true
    }
    
}
