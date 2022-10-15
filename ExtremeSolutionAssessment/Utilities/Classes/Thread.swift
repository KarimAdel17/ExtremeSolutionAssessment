//
//  Thread.swift
//  ExtremeSolutionAssessment
//
//  Created by Karim on 15/10/2022.
//

import Foundation

public protocol Scopable {}

public extension Scopable where Self: AnyObject {
    func with(_ closure: (Self) throws -> Void) rethrows -> Self {
        try closure(self)
        return self
    }

    func apply(onMainThread: Bool = false, _ closure: @escaping (Self) throws -> Void) rethrows {
        guard !Thread.isMainThread, onMainThread else {
            try closure(self)
            return
        }

        DispatchQueue.main.async(
            execute: { [weak self] in
                guard let self = self else { return }
                try? closure(self)
            }
        )
        return
    }
}

extension NSObject: Scopable {}
