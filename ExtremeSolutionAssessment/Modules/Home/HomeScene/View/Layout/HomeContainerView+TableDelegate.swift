//
//  HomeContainerView+TableDelegate.swift
//  ExtremeSolutionAssessment
//
//  Created by Karim on 15/10/2022.
//

import Foundation
import UIKit

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
        
        onTapCell?(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         180
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let lastSectionIndex = herosTableView.numberOfSections - 1
            let lastRowIndex = herosTableView.numberOfRows(inSection: lastSectionIndex) - 1
            if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
                let spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
                spinner.startAnimating()
                spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(50))

                self.herosTableView.tableFooterView = spinner
                self.herosTableView.tableFooterView?.isHidden = false
                if viewModel.getTotal() > viewModel.getCurrent() {
                    Pagination?()
                }
            }
    }
}
