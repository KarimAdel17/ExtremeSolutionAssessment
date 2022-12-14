//
//  Coordinator.swift
//  ExtremeSolutionAssessment
//
//  Created by Karim on 14/10/2022.
//

import Foundation
import UIKit

protocol CoordinatorProtocol: AnyObject {
    func start()
    func navigateTo(_ hero: HerosData)
    func popViewController()
    func presentSearch()
    func dismissSearch()
}

final class Coordinator {
    typealias Factory = SplashFactory & HomeFactory & HeroDescriptionFactory & SearchFactory

    var splashCoordinator: SplashCoordinatorProtocol {
        didSet {
            splashCoordinator.delegate = self
        }
    }
    
    var homeCoordinator: HomeCoordinatorProtocol {
        didSet {
            homeCoordinator.delegate = self
        }
    }
    
    var heroDescriptionCoordinator: HeroDescriptionCoordinatorProtocol {
        didSet {
            heroDescriptionCoordinator.delegate = self
        }
    }
    
    var searchCoordinator: SearchCoordinatorProtocol {
        didSet {
            searchCoordinator.delegate = self
        }
    }

    let navigationController = UINavigationController()

    private let window: UIWindow

    init(factory: Factory, window: UIWindow) {
        splashCoordinator = ExtremeSolutionAssessment.SplashCoordinator(factory: factory)
        homeCoordinator = ExtremeSolutionAssessment.HomeCoordinator(factory: factory)
        heroDescriptionCoordinator = ExtremeSolutionAssessment.HeroDescriptionCoordinator(factory: factory)
        searchCoordinator = ExtremeSolutionAssessment.SearchCoordinator(factory: factory)
        
        let splash = splashCoordinator.start()
        
        self.window = window
        navigationController.isNavigationBarHidden = true
        self.window.rootViewController = splash
        self.window.makeKeyAndVisible()

        splashCoordinator.delegate = self
        homeCoordinator.delegate = self
        heroDescriptionCoordinator.delegate = self
        searchCoordinator.delegate = self
    }
}

extension Coordinator: CoordinatorProtocol {
    func start() {
        self.window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
        let viewController = homeCoordinator.start()
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func navigateTo(_ hero: HerosData) {
        let viewController = heroDescriptionCoordinator.start(hero: hero)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func popViewController() {
        navigationController.popViewController(animated: true)
    }
    
    func presentSearch() {
        let viewController = searchCoordinator.start()
        viewController.modalPresentationStyle = .overFullScreen
        navigationController.present(viewController, animated: true)
    }
    
    func dismissSearch() {
        navigationController.dismiss(animated: true)
    }
}

extension Coordinator: HomeCoordinatorDelegate {
    func homeCoordinator(_: HomeCoordinator, didOpenHero hero: HerosData) {
        navigateTo(hero)
    }
    
    func homeCoordinator(_ HomeCoordinator: HomeCoordinator) {
        presentSearch()
    }
}
    
extension Coordinator: HeroDescriptionCoordinatorDelegate {
    func heroDescriptionCoordinator(_ HeroDescriptionCoordinator: HeroDescriptionCoordinator) {
        popViewController()
    }
}

extension Coordinator: SearchCoordinatorDelegate {
    func searchCoordinator(_ SearchCoordinator: SearchCoordinator, didOpenHero hero: HerosData) {
        dismissSearch()
        navigateTo(hero)
    }
    
    func searchCoordinator(_ SearchCoordinator: SearchCoordinator) {
        dismissSearch()
    }
}

extension Coordinator: SplashCoordinatorDelegate {
    func splashCoordinator(_ SplashCoordinator: SplashCoordinator) {
        start()
    }
}
