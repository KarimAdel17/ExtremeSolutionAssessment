//
//  HomeViewModel.swift
//  ExtremeSolutionAssessment
//
//  Created by Karim on 14/10/2022.
//

import Foundation

class HomeViewModel {
    private let factory: HomeFactory

    private lazy var homeManager = factory.makeHomeManager()

    public init(factory: HomeFactory) {
        self.factory = factory
    }
    
    private var heros = [HerosData]()
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
    
    func heros(_ observer: @escaping Observer<DataClass>) -> Disposable {
        
        offset += 20
        
        return homeManager.heros({ [weak self] result in
            switch result {
            case let .success(herosData):
                self?.total = herosData.total
                self?.count = herosData.count
                if let heros = herosData.results {
                    self?.heros.append(contentsOf: heros)
                }
            case .failure:
                break
            }
            observer(result)
        }, offset: offset)
    }
}
