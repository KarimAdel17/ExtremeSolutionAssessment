//
//  HomeManager.swift
//  ExtremeSolutionAssessment
//
//  Created by Karim on 14/10/2022.
//

import Foundation

protocol HomeManagerProtocol {
    @discardableResult
    func heros(_ observer: @escaping Observer<DataClass>, offset: Int) -> Disposable
    func fetchHeros(offset: Int)
}

struct HomeManager {
    let networkManager: NetworkManagerProtocol

    public init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
}

extension HomeManager: HomeManagerProtocol {
    @discardableResult
    public func heros(_ observer: @escaping Observer<DataClass>, offset: Int) -> Disposable {
        
        networkManager
            .observe(.getHeros(offset: offset), { result in
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
            })
    }

    public func fetchHeros(offset: Int) {
        print(offset)
        networkManager.execute(.getHeros(offset: offset))
    }
}
