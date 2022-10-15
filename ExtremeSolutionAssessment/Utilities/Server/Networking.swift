//
//  Networking.swift
//  ExtremeSolutionAssessment
//
//  Created by Karim on 15/10/2022.
//

import Foundation
import Moya

enum Networking: Hashable {
    case getHeros(offset: Int)
    case getSearchHeros(searchText: String)
}

extension Networking: TargetType {
    var sampleData: Data {
        return Data()
    }
    
    var baseURL: URL {
        return URL(string: "https://gateway.marvel.com/")!
    }
    
    var method: Moya.Method {
        switch self {
        case .getHeros, .getSearchHeros:
            return .get
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getHeros, .getSearchHeros:
            return ["Accept":"application/json"]
        }
    }
    
    var path: String {
        switch self {
        case .getHeros, .getSearchHeros:
            return "v1/public/characters"
        }
    }

    var task: Task {
        switch self {
        case let .getHeros(offset):
            return .requestParameters(parameters: ["apikey":"667c2ea342db649c8fdb6917c4493160", "hash":"b637bc4d295f2a02c41a265e267c90e8", "ts":"20:56:38Z", "offset":offset], encoding: URLEncoding.queryString)
        case let .getSearchHeros(searchText):
            return .requestParameters(parameters: ["apikey":"667c2ea342db649c8fdb6917c4493160", "hash":"b637bc4d295f2a02c41a265e267c90e8", "ts":"20:56:38Z", "nameStartsWith": searchText], encoding: URLEncoding.queryString)
        }
    }
}
