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
}

final class Coordinator {
    typealias Factory = HomeFactory & HeroDescriptionFactory

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

    let navigationController = UINavigationController()

    private let window: UIWindow

    init(factory: Factory, window: UIWindow) {
        homeCoordinator = ExtremeSolutionAssessment.HomeCoordinator(factory: factory)
        heroDescriptionCoordinator = ExtremeSolutionAssessment.HeroDescriptionCoordinator(factory: factory)

        self.window = window
        navigationController.isNavigationBarHidden = true
        self.window.rootViewController = navigationController
        self.window.makeKeyAndVisible()

        homeCoordinator.delegate = self
        heroDescriptionCoordinator.delegate = self
    }
}

extension Coordinator: CoordinatorProtocol {
    func start() {
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
}

extension Coordinator: HomeCoordinatorDelegate {
    func HomeCoordinator(_: HomeCoordinator, didOpenHero hero: HerosData) {
        navigateTo(hero)
    }
}
    
extension Coordinator: HeroDescriptionCoordinatorDelegate {
    func HeroDescriptionCoordinator(_ HeroDescriptionCoordinator: HeroDescriptionCoordinator) {
        popViewController()
    }
}
