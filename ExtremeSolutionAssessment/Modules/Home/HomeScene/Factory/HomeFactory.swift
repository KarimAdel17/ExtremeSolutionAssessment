//
//  HomeFactory.swift
//  ExtremeSolutionAssessment
//
//  Created by Karim on 14/10/2022.
//

import Foundation

protocol HomeFactory {
    func makeHomeManager() -> HomeManagerProtocol
    func makeHomeViewController() -> HomeViewController
}
