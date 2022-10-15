//
//  SplashViewController.swift
//  ExtremeSolutionAssessment
//
//  Created by Karim on 13/10/2022.
//

import UIKit

protocol SplashViewControllerDelegate: AnyObject {
    func splashViewController(_ SplashViewController: SplashViewController)
}

class SplashViewController: UIViewController {
    
    weak var delegate: SplashViewControllerDelegate?
    
    lazy var containerView = SplashContainerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        splashInterval()
        // Do any additional setup after loading the view.
    }

    override func loadView() {
        super.loadView()
        self.view = containerView
    }
    
    private func splashInterval() {
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { _ in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.delegate?.splashViewController(self)
            }
        }
    }
}
