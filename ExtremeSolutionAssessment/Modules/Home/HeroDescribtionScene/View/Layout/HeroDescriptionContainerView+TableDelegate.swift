//
//  HeroDescriptionContainerView+TableDelegate.swift
//  ExtremeSolutionAssessment
//
//  Created by Karim on 15/10/2022.
//

import Foundation
import UIKit

extension HeroDescribtionContainerView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getShowsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(HeroShowsTableViewCell.self), for: indexPath) as? HeroShowsTableViewCell else {
            return HeroShowsTableViewCell()
        }
        
        guard indexPath.row < viewModel.getShowsCount() else {
            return cell
        }

        let show = viewModel.getShow(index: indexPath.row)
        return bind(show, with: cell)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         170
    }
}
