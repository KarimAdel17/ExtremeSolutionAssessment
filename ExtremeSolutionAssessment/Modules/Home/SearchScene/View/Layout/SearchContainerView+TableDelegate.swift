//
//  SearchContainerView+TableDelegate.swift
//  ExtremeSolutionAssessment
//
//  Created by Karim on 15/10/2022.
//

import Foundation
import UIKit

extension SearchContainerView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let searchBar = searchBar.searchTextField.text, !searchBar.isEmpty else {
            return 0
        }
        return viewModel.getHerosCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(SearchHerosTableViewCell.self), for: indexPath) as? SearchHerosTableViewCell else {
            return SearchHerosTableViewCell()
        }
        
        let hero = viewModel.getHero(index: indexPath.row)
        return bind(hero, with: cell)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let searchText = searchBar.searchTextField.text {
            if indexPath.row == (viewModel.getHerosCount() - 3) {
                if viewModel.getTotal() > viewModel.getCurrent() {
                    Pagination?(searchText)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onTapCell?(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         100
    }
}
