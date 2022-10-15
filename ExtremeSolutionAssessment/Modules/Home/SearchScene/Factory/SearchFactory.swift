//
//  SearchFactory.swift
//  ExtremeSolutionAssessment
//
//  Created by Karim on 15/10/2022.
//

import Foundation

protocol SearchFactory {
    func makeSearchManager() -> SearchManagerProtocol
    func makeSearchViewController() -> SearchViewController
}
