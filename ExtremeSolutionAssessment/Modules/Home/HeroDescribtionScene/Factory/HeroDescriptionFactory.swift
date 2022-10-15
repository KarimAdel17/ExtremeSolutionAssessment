//
//  HeroDescriptionFactory.swift
//  ExtremeSolutionAssessment
//
//  Created by Karim on 15/10/2022.
//

import Foundation

protocol HeroDescriptionFactory {
    func makeHeroDescriptionManager(for hero: HerosData) -> HeroDescriptionManagerProtocol
    func makeHeroDescriptionViewController(for hero: HerosData) -> HeroDescribtionViewController
}
