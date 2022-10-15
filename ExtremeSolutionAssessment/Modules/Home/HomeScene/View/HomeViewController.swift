//
//  HomeViewController.swift
//  ExtremeSolutionAssessment
//
//  Created by Karim on 13/10/2022.
//

import UIKit
import Kingfisher

protocol HomeViewControllerDelegate: AnyObject {
    func HomeViewController(_ HomeViewController: HomeViewController, didSelectHero hero: HerosData)
}

class HomeViewController: UIViewController {
    
    weak var delegate: HomeViewControllerDelegate?
    
    var viewModel: HomeViewModel!
    
    let disposeBag = DisposeBag()
    
    let network = NetworkManager()
    
    
    lazy var containerView: HomeContainerView = {
        let view = HomeContainerView(viewModel: viewModel)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        getData()
        
        containerView.Pagination = { [weak self] in
            self?.getData()
        }
        
        containerView.onTapSearch = { [weak self] in
            let vc = SearchViewController()
            vc.modalPresentationStyle = .overFullScreen
//            self.navigationController?.pushViewController(vc, animated: true)
            self?.present(vc, animated: true)
        }
        
        containerView.onTapCell = { [weak self] index in
            guard let self = self else { return }
            self.delegate?.HomeViewController(self, didSelectHero: self.viewModel.getHero(index: index))
        }
        
//        containerView.onTapCell = { [weak self] in
//
//
//
////            let vc = HeroDescribtionViewController()
////            self?.navigationController?.pushViewController(vc, animated: true)
//        }
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
    
    func getData() {
        viewModel
            .heros { [weak self] result in
                switch result {
                case .success:
//                    self?.apply(onMainThread: true) {
                    self?.containerView.herosTableView.reloadData()
//                        $0.refreshControl?.endRefreshing()
//                    }
                case let .failure(error):
                    print(error)
//                    self?.present(error)
                }
            }.disposed(by: disposeBag)
    }
}
