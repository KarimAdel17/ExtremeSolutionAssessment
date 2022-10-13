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
        containerView.onTapSearch = {
            let vc = SearchViewController()
            vc.modalPresentationStyle = .overFullScreen
//            self.navigationController?.pushViewController(vc, animated: true)
            self.present(vc, animated: true)
        }
        
        containerView.onTapCell = {
            let vc = HeroDescribtionViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        super.loadView()
        self.view = containerView
    }
}
