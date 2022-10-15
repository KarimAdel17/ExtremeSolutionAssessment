//
//  HeroDescriptionManager.swift
//  ExtremeSolutionAssessment
//
//  Created by Karim on 15/10/2022.
//

import Foundation

protocol HeroDescriptionManagerProtocol {
    func hero(_ observer: @escaping Observer<HerosData>)
    func items(_ observer: @escaping Observer<ItemsDataClass>, url: String) -> Disposable
}

struct HeroDescriptionManager {
    let hero: HerosData

    let networkManager: NetworkManagerProtocol
    
    public init(hero: HerosData, networkManager: NetworkManagerProtocol) {
        self.hero = hero
        self.networkManager = networkManager
    }
}

extension HeroDescriptionManager: HeroDescriptionManagerProtocol {
    func items(_ observer: @escaping Observer<ItemsDataClass>, url: String) -> Disposable {
        networkManager.observe(.getComics(url: url)) { result in
            switch result {
            case let .success(data):
                do {
                    let home = try JSONDecoder().decode(Items.self, from: data)
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
    
    public func hero(_ observer: @escaping Observer<HerosData>) {
        observer(.success(hero))
    }
}
