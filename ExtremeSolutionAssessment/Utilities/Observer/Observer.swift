//
//  Observer.swift
//  ExtremeSolutionAssessment
//
//  Created by Karim on 13/10/2022.
//

import Foundation

typealias Observer<T> = (Result<T, Error>) -> Void
