//
//  SearchViewController.swift
//  ExtremeSolutionAssessment
//
//  Created by Karim on 13/10/2022.
//

import UIKit

protocol SearchViewControllerDelegate: AnyObject {
    func searchViewController(_ SearchViewController: SearchViewController, didSelectHero hero: HerosData)
    func dismissSearchViewController()
}

class SearchViewController: UIViewController {
    
    weak var delegate: SearchViewControllerDelegate?
    
    var viewModel: SearchViewModel!
    
    let disposeBag = DisposeBag()
    
    let network = NetworkManager()
    
    lazy var containerView: SearchContainerView = {
        let view = SearchContainerView(viewModel: viewModel)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        containerView.onTapSearch = { [weak self] searchText in
            self?.getSearchData(searchText: searchText)
        }
        
        containerView.onTapCancel = { [weak self] in
            self?.delegate?.dismissSearchViewController()
        }
        
        containerView.onTapCell = { [weak self] index in
            guard let self = self else { return }
            self.delegate?.searchViewController(self, didSelectHero: self.viewModel.getHero(index: index))
        }
        
//        let backgroundImage = getImageWithCustomColor(color: UIColor.clear, size: CGSize(width: 60, height: 60))
//
//        containerView.searchBar.setSearchFieldBackgroundImage(backgroundImage, for: .normal)
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
    
    func getSearchData(searchText: String) {
        
        viewModel.searchHeros({ [weak self] result in
            switch result {
            case .success:
//                    self?.apply(onMainThread: true) {
                self?.containerView.searchHerosTableView.reloadData()
//                        $0.refreshControl?.endRefreshing()
//                    }
            case let .failure(error):
                print(error)
//                    self?.present(error)
            }
        }, searchText: searchText).disposed(by: disposeBag)
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
