//
//  HomeViewController.swift
//  ExtremeSolutionAssessment
//
//  Created by Karim on 13/10/2022.
//

import UIKit

class HomeViewController: UIViewController {

    lazy var containerView = HomeContainerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        super.loadView()
        self.view = containerView
    }
}
