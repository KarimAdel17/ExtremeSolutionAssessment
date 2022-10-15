//
//  SearchManager.swift
//  ExtremeSolutionAssessment
//
//  Created by Karim on 15/10/2022.
//

import Foundation

protocol SearchManagerProtocol {
    @discardableResult
    func searchHeros(_ observer: @escaping Observer<DataClass>, searchText: String) -> Disposable
}

struct SearchManager {
    let networkManager: NetworkManagerProtocol

    public init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
}

extension SearchManager: SearchManagerProtocol {
    @discardableResult
    public func searchHeros(_ observer: @escaping Observer<DataClass>, searchText: String) -> Disposable {
        
        networkManager.observe(.getSearchHeros(searchText: searchText)) { result in
            switch result {
            case let .success(data):
                do {
                    let home = try JSONDecoder().decode(Home.self, from: data)
                    print(home)
                    if let herosData = home.data {
                        observer(.success(herosData))
                    }
                } catch {
                    observer(.failure(error))
                }
                
            case let .failure(error):
                observer(.failure(error))
            }
        }
    }
}
