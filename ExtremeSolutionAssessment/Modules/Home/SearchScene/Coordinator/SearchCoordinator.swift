//
//  SearchCoordinator.swift
//  ExtremeSolutionAssessment
//
//  Created by Karim on 15/10/2022.
//

import Foundation
import UIKit

protocol SearchCoordinatorDelegate: AnyObject {
    func searchCoordinator(_ SearchCoordinator: SearchCoordinator, didOpenHero hero: HerosData)
    func searchCoordinator(_ SearchCoordinator: SearchCoordinator)
}

protocol SearchCoordinatorProtocol: AnyObject {
    var delegate: SearchCoordinatorDelegate? { get set }

    func start() -> UIViewController
}

public final class SearchCoordinator {
    
    weak var delegate: SearchCoordinatorDelegate?

    private let factory: SearchFactory

    init(factory: SearchFactory) {
        self.factory = factory
    }
}

extension SearchCoordinator: SearchCoordinatorProtocol {
    public func start() -> UIViewController {
        let viewController = factory.makeSearchViewController()
        viewController.delegate = self
        return viewController
    }
}

extension SearchCoordinator: SearchViewControllerDelegate {
    func searchViewController(_: SearchViewController, didSelectHero hero: HerosData) {
        delegate?.searchCoordinator(self, didOpenHero: hero)
    }
    
    func dismissSearchViewController() {
        delegate?.searchCoordinator(self)
    }
}
