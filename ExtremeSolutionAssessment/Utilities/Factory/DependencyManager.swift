//
//  DependencyManager.swift
//  ExtremeSolutionAssessment
//
//  Created by Karim on 14/10/2022.
//

import Foundation

struct DependencyManager {
    let networkManager: NetworkManagerProtocol
}

extension DependencyManager: HomeFactory {
    func makeHomeManager() -> HomeManagerProtocol {
        HomeManager(networkManager: networkManager)
    }

    func makeHomeViewController() -> HomeViewController {
        let viewController = HomeViewController()
        viewController.viewModel = HomeViewModel(factory: self)

        return viewController
    }
}
