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
        
        containerView.Pagination = { [weak self] searchText in
            self?.getPaginatedSearchData(searchText: searchText)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        disposeBag.dispose()
    }

    override func loadView() {
        super.loadView()
        self.view = containerView
    }
    
    func getPaginatedSearchData(searchText: String) {
        viewModel.paginatedSearchHeros({ [weak self] result in
            switch result {
            case .success:
                    self?.apply(onMainThread: true) { _ in
                self?.containerView.searchHerosTableView.reloadData()
                    }
            case let .failure(error):
                print(error)
            }
        }, searchText: searchText).disposed(by: disposeBag)
    }
    
    func getSearchData(searchText: String) {
        
        viewModel.searchHeros({ [weak self] result in
            switch result {
            case .success:
                self?.apply(onMainThread: true) {_ in
                self?.containerView.searchHerosTableView.reloadData()
                    }
            case let .failure(error):
                print(error)
            }
        }, searchText: searchText).disposed(by: disposeBag)
    }
}
