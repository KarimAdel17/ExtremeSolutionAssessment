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

extension DependencyManager: SplashFactory {
    func makeSplashViewController() -> SplashViewController {
        let viewController = SplashViewController()

        return viewController
    }
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

extension DependencyManager: HeroDescriptionFactory {
    
    func makeHeroDescriptionManager(for hero: HerosData) -> HeroDescriptionManagerProtocol {
        HeroDescriptionManager(hero: hero, networkManager: networkManager)
    }
    
    func makeHeroDescriptionViewController(for hero: HerosData) -> HeroDescribtionViewController {
        let viewController = HeroDescribtionViewController()
        viewController.viewModel = HeroDescriptionViewModel(factory: self, hero: hero)
        
        return viewController
    }
}

extension DependencyManager: SearchFactory {
    func makeSearchManager() -> SearchManagerProtocol {
        SearchManager(networkManager: networkManager)
    }
    
    func makeSearchViewController() -> SearchViewController {
        let viewController = SearchViewController()
        viewController.viewModel = SearchViewModel(factory: self)

        return viewController
    }
}
