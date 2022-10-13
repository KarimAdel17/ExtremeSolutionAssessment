//
//  SearchViewController.swift
//  ExtremeSolutionAssessment
//
//  Created by Karim on 13/10/2022.
//

import UIKit

class SearchViewController: UIViewController {
    
    lazy var containerView = SearchContainerView()

    override func viewDidLoad() {
        super.viewDidLoad()
//        let backgroundImage = getImageWithCustomColor(color: UIColor.clear, size: CGSize(width: 60, height: 60))
//
//        containerView.searchBar.setSearchFieldBackgroundImage(backgroundImage, for: .normal)
        // Do any additional setup after loading the view.
    }

    override func loadView() {
        super.loadView()
        self.view = containerView
    }
    
    func getImageWithCustomColor(color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 0, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}
