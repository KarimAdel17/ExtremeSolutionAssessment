//
//  SplashCoordinator.swift
//  ExtremeSolutionAssessment
//
//  Created by Karim on 15/10/2022.
//

import Foundation
import UIKit

protocol SplashCoordinatorDelegate: AnyObject {
    func splashCoordinator(_ SplashCoordinator: SplashCoordinator)
}

protocol SplashCoordinatorProtocol: AnyObject {
    var delegate: SplashCoordinatorDelegate? { get set }

    func start() -> UIViewController
}

public final class SplashCoordinator {
    
    weak var delegate: SplashCoordinatorDelegate?

    private let factory: SplashFactory

    init(factory: SplashFactory) {
        self.factory = factory
    }
}

extension SplashCoordinator: SplashCoordinatorProtocol {
    public func start() -> UIViewController {
        let viewController = factory.makeSplashViewController()
        viewController.delegate = self
        return viewController
    }
}

extension SplashCoordinator: SplashViewControllerDelegate {
    
    func splashViewController(_ SplashViewController: SplashViewController) {
        delegate?.splashCoordinator(self)
    }
}
