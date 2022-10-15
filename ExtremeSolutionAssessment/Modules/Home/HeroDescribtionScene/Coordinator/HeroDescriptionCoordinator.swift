//
//  HeroDescriptionCoordinator.swift
//  ExtremeSolutionAssessment
//
//  Created by Karim on 15/10/2022.
//

import Foundation
import UIKit

protocol HeroDescriptionCoordinatorDelegate: AnyObject {
    func heroDescriptionCoordinator(_ HeroDescriptionCoordinator: HeroDescriptionCoordinator)
}

protocol HeroDescriptionCoordinatorProtocol: AnyObject {
    var delegate: HeroDescriptionCoordinatorDelegate? { get set }

    func start(hero: HerosData) -> UIViewController
}

public final class HeroDescriptionCoordinator {
    
    weak var delegate: HeroDescriptionCoordinatorDelegate?

    private let factory: HeroDescriptionFactory

    init(factory: HeroDescriptionFactory) {
        self.factory = factory
    }
}

extension HeroDescriptionCoordinator: HeroDescriptionCoordinatorProtocol {
    func start(hero: HerosData) -> UIViewController {
        let viewController = factory.makeHeroDescriptionViewController(for: hero)
        viewController.delegate = self
        return viewController
    }
}

extension HeroDescriptionCoordinator: HeroDescriptionViewControllerDelegate {
    
    func popHeroDescriptionViewController() {
        delegate?.heroDescriptionCoordinator(self)
    }
}
