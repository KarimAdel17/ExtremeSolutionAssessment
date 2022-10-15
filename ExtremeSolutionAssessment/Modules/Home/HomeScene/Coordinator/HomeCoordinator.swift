//
//  HomeCoordinator.swift
//  ExtremeSolutionAssessment
//
//  Created by Karim on 14/10/2022.
//

import Foundation
import UIKit

protocol HomeCoordinatorDelegate: AnyObject {
    func homeCoordinator(_ HomeCoordinator: HomeCoordinator, didOpenHero hero: HerosData)
    func homeCoordinator(_ HomeCoordinator: HomeCoordinator)
}

protocol HomeCoordinatorProtocol: AnyObject {
    var delegate: HomeCoordinatorDelegate? { get set }

    func start() -> UIViewController
}

public final class HomeCoordinator {
    
    weak var delegate: HomeCoordinatorDelegate?

    private let factory: HomeFactory

    init(factory: HomeFactory) {
        self.factory = factory
    }
}

extension HomeCoordinator: HomeCoordinatorProtocol {
    public func start() -> UIViewController {
        let viewController = factory.makeHomeViewController()
        viewController.delegate = self
        return viewController
    }
}

extension HomeCoordinator: HomeViewControllerDelegate {
    func homeViewController(_: HomeViewController, didSelectHero hero: HerosData) {
        delegate?.homeCoordinator(self, didOpenHero: hero)
    }
    
    func homeViewController(_ HomeViewController: HomeViewController) {
        delegate?.homeCoordinator(self)
    }
}
