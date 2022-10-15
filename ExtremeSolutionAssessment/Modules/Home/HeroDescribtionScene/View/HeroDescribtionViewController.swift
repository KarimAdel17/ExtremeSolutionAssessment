//
//  HeroDescribtionViewController.swift
//  ExtremeSolutionAssessment
//
//  Created by Karim on 13/10/2022.
//

import UIKit

protocol HeroDescriptionViewControllerDelegate: AnyObject {
    func popHeroDescriptionViewController()
}

class HeroDescribtionViewController: UIViewController {
    
    weak var delegate: HeroDescriptionViewControllerDelegate?
    
    var viewModel: HeroDescriptionViewModel!
    
    let disposeBag = DisposeBag()
    
    lazy var containerView: HeroDescribtionContainerView = {
        let view = HeroDescribtionContainerView(viewModel: viewModel)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.hero { [weak self] result in
            switch result {
            case let .success(hero):
                self?.bind(hero)

            case let .failure(error):
                print(error)
            }
        }
        
        containerView.onTapBackBTN = {
            self.delegate?.popHeroDescriptionViewController()
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        disposeBag.dispose()
    }

    override func loadView() {
        super.loadView()
        self.view = containerView
    }
}

extension HeroDescribtionViewController {
    func bind(_ hero: HerosData) {
        if let path = hero.thumbnail?.path, let imageExtension = hero.thumbnail?.thumbnailExtension {
            let allPath = path + "." + imageExtension
            if let url = URL(string: allPath) {
                self.containerView.heroImage.kf.indicatorType = .activity
                self.containerView.heroImage.kf.setImage(with: url)
                self.containerView.backgroundImage.kf.indicatorType = .activity
                self.containerView.backgroundImage.kf.setImage(with: url)
            }
        }
        self.containerView.heroName.text = hero.name
        if let heroDescription = hero.resultDescription, !heroDescription.isEmpty {
            self.containerView.descriptionLabel.isHidden = false
            self.containerView.desc.isHidden = false
            self.containerView.desc.text = hero.resultDescription
        }
        self.viewModel.setShows()
        self.containerView.heroShowsTableView.reloadData()
    }
}
