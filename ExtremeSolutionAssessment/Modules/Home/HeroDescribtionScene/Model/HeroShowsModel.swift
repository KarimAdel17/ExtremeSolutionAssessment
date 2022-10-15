//
//  HeroShowsModel.swift
//  ExtremeSolutionAssessment
//
//  Created by Karim on 15/10/2022.
//

import Foundation

struct HeroShows {
    let showKind: String?
    let show: Comics?
}

struct Items: Codable {
    let code: Int?
    let status, copyright, attributionText, attributionHTML: String?
    let etag: String?
    let data: ItemsDataClass?
}

struct ItemsDataClass: Codable {
    let offset, limit, total, count: Int?
    let results: [ItemsData]?
}

struct ItemsData: Codable {
    let id: Int?
    let title: String?
    let resultDescription: String?
    let resourceURI: String?
    let urls: [URLElement]?
    let startYear, endYear: Int?
    let rating, type: String?
    let modified: String?
    let thumbnail: Thumbnail?
    let creators: Creators?
    let characters: Characters?
    let stories: Stories?
    let comics, events: Characters?
    let next, previous: String?

    enum CodingKeys: String, CodingKey {
        case id, title
        case resultDescription = "description"
        case resourceURI, urls, startYear, endYear, rating, type, modified, thumbnail, creators, characters, stories, comics, events, next, previous
    }
}

struct Characters: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [CharactersItem]?
    let returned: Int?
}

struct CharactersItem: Codable {
    let resourceURI: String?
    let name: String?
}

struct Creators: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [CreatorsItem]?
    let returned: Int?
}

struct CreatorsItem: Codable {
    let resourceURI: String?
    let name, role: String?
}

struct Stories: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [StoriesItem]?
    let returned: Int?
}

struct StoriesItem: Codable {
    let resourceURI: String?
    let name: String?
    let type: String?
}
