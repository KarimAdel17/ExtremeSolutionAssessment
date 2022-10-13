//
//  SplashViewController.swift
//  ExtremeSolutionAssessment
//
//  Created by Karim on 13/10/2022.
//

import UIKit

class SplashViewController: UIViewController {
    
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
            DispatchQueue.main.async {
                let homeViewController = HomeViewController()
                
                let navigationController = UINavigationController(rootViewController: homeViewController)
                navigationController.isNavigationBarHidden = true
                self.view.window?.rootViewController = navigationController
            }
        }
    }
}
