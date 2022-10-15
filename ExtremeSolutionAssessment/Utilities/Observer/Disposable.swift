//
//  Disposable.swift
//  ExtremeSolutionAssessment
//
//  Created by Karim on 13/10/2022.
//

import Foundation

public struct Disposable {
    let closure: () -> Void

    public init(_ closure: @escaping () -> Void) {
        self.closure = closure
    }
}

public extension Disposable {
    func disposed(by disposeBag: DisposeBag) {
        disposeBag.disposables.append(self)
    }
}
