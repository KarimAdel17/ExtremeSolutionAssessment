//
//  NetworkManager.swift
//  ExtremeSolutionAssessment
//
//  Created by Karim on 13/10/2022.
//

import Foundation
import Moya

protocol NetworkManagerProtocol {
    @discardableResult
    func observe(_ request: Networking, _ observer: @escaping Observer<Data>) -> Disposable
    func execute(_ request: Networking)
}

final class NetworkManager {
    
    let provider = MoyaProvider<Networking>(plugins: [NetworkLoggerPlugin()])
    
    private(set) var observables: [Networking: [UUID: Observer<Data>]]
    
    public init(
        observables: [Networking: [UUID: Observer<Data>]] = [:]
    ) {
        self.observables = observables
    }
    
    private func execute(_ request: Networking, with observers: [Observer<Data>]) {
        provider.request(request) { result in
            switch result {
            case .success(let response):
                observers.forEach { $0(.success(response.data)) }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension NetworkManager: NetworkManagerProtocol {
    @discardableResult
    public func observe(_ request: Networking, _ observer: @escaping Observer<Data>) -> Disposable {
        let uuid = UUID()
        var observers = observables[request] ?? [:]
        observers[uuid] = observer
        observables[request] = observers
        
        execute(request, with: [observer])
        
        return Disposable { [weak self] in
            self?.observables[request]?.removeValue(forKey: uuid)
        }
    }
    
    public func execute(_ request: Networking) {
        guard let observers = observables[request] else {
            return
        }
        execute(request, with: observers.map { $0.value })
    }
}

