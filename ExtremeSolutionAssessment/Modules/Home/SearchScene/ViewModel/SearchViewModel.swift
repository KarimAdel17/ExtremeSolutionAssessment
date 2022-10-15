//
//  SearchViewModel.swift
//  ExtremeSolutionAssessment
//
//  Created by Karim on 15/10/2022.
//

import Foundation

class SearchViewModel {
    private let factory: SearchFactory
    
    private lazy var SearchManager = factory.makeSearchManager()
    
    public init(factory: SearchFactory) {
        self.factory = factory
    }
    
    private var heros = [HerosData]()
    //    private var offset: Int?
    private var offset = -20
    private var total: Int?
    private var count: Int?
    
    func getHerosCount() -> Int {
        heros.count
    }
    
    func getHero(index: Int) -> HerosData {
        heros[index]
    }
    
    func getTotal() -> Int {
        guard let total = total else {
            return 0
        }
        return total
    }
    
    func getCurrent() -> Int {
        guard let count = count else {
            return 0
        }
        return count
    }
    
    func searchHeros(_ observer: @escaping Observer<DataClass>, searchText: String) -> Disposable {
        
//        offset += 20
//        if searchText.isEmpty {
//            heros.removeAll()
//        }
        
        return SearchManager.searchHeros({ [weak self] result in
            switch result {
            case let .success(herosData):
                self?.total = herosData.total
                self?.count = herosData.count
                if let heros = herosData.results {
                    self?.heros = heros
                }
            case let .failure(error):
                print(error)
            }
            observer(result)
        }, searchText: searchText)
    }
}
