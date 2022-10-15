//
//  HeroDescriptionViewModel.swift
//  ExtremeSolutionAssessment
//
//  Created by Karim on 15/10/2022.
//

import Foundation

class HeroDescriptionViewModel {
    private let factory: HeroDescriptionFactory
    private let hero: HerosData
    
    private var heroShows = [HeroShows]()

    private lazy var heroDescriptionManager = factory.makeHeroDescriptionManager(for: hero)

    public init(factory: HeroDescriptionFactory, hero: HerosData) {
        self.factory = factory
        self.hero = hero
    }
    
    func hero(_ observer: @escaping Observer<HerosData>) {
        heroDescriptionManager.hero(observer)
    }
    
    func setShows() {
        if let heroComics = hero.comics?.items, heroComics.count > 0 {
            heroShows.append(HeroShows(showKind: "Comics", show: heroComics))
        }
        
        if let heroEvents = hero.events?.items, heroEvents.count > 0 {
            heroShows.append(HeroShows(showKind: "Events", show: heroEvents))
        }
        
        if let heroSeries = hero.series?.items, heroSeries.count > 0 {
            heroShows.append(HeroShows(showKind: "Series", show: heroSeries))
        }
        
        if let heroStories = hero.stories?.items, heroStories.count > 0 {
            heroShows.append(HeroShows(showKind: "stories", show: heroStories))
        }
    }
    
    func getShowsCount() -> Int {
        heroShows.count
    }
    
    func getShow(index: Int) -> HeroShows {
        heroShows[index]
    }
}
