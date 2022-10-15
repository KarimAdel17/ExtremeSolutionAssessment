//
//  HeroDescriptionManager.swift
//  ExtremeSolutionAssessment
//
//  Created by Karim on 15/10/2022.
//

import Foundation

protocol HeroDescriptionManagerProtocol {
    func hero(_ observer: @escaping Observer<HerosData>)
}

struct HeroDescriptionManager {
    let hero: HerosData

    public init(hero: HerosData) {
        self.hero = hero
    }
}

extension HeroDescriptionManager: HeroDescriptionManagerProtocol {
    public func hero(_ observer: @escaping Observer<HerosData>) {
        observer(.success(hero))
    }
}
