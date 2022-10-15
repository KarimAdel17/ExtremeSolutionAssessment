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
}

final class Coordinator {
    typealias Factory = HomeFactory

    var HomeCoordinator: HomeCoordinatorProtocol {
        didSet {
            HomeCoordinator.delegate = self
        }
    }

    let navigationController = UINavigationController()

    private let window: UIWindow

    init(factory: Factory, window: UIWindow) {
        HomeCoordinator = ExtremeSolutionAssessment.HomeCoordinator(factory: factory)

        self.window = window
        navigationController.isNavigationBarHidden = true
        self.window.rootViewController = navigationController
        self.window.makeKeyAndVisible()

        HomeCoordinator.delegate = self
    }
}

extension Coordinator: CoordinatorProtocol {
    func start() {
        let viewController = HomeCoordinator.start()
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func navigateTo(_ hero: HerosData) {
        let viewController = HeroDescriptionCoordinator.start()
        viewController.heroId = hero.id
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension Coordinator: HomeCoordinatorDelegate {
    func HomeCoordinator(_: HomeCoordinator, didOpenHero hero: HerosData) {
        navigateTo(hero)
    }
}
