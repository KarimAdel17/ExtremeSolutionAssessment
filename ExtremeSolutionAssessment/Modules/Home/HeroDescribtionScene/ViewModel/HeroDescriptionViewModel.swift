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
    
    private var items = [ItemsData]()

    private lazy var heroDescriptionManager = factory.makeHeroDescriptionManager(for: hero)

    public init(factory: HeroDescriptionFactory, hero: HerosData) {
        self.factory = factory
        self.hero = hero
    }
    
    func hero(_ observer: @escaping Observer<HerosData>) {
        heroDescriptionManager.hero(observer)
    }
    
    func getItems() -> [ItemsData] {
        items
    }
    
    func items(_ observer: @escaping Observer<ItemsDataClass>, url: String) -> Disposable {
                
        return heroDescriptionManager.items({ [weak self] result in
            switch result {
            case let .success(itemsData):
                if let items = itemsData.results {
                    self?.items = items
                }
            case .failure:
                break
            }
            observer(result)
        }, url: url)
    }
    
    func setShows() {
        if let heroComics = hero.comics, let heroItems = heroComics.items, heroItems.count > 0 {
            heroShows.append(HeroShows(showKind: "Comics", show: heroComics))
        }
        
        if let heroEvents = hero.events, let heroItems = heroEvents.items, heroItems.count > 0 {
            heroShows.append(HeroShows(showKind: "Events", show: heroEvents))
        }
        
        if let heroSeries = hero.series, let heroItems = heroSeries.items, heroItems.count > 0 {
            heroShows.append(HeroShows(showKind: "Series", show: heroSeries))
        }
        
        if let heroStories = hero.stories, let heroItems = heroStories.items, heroItems.count > 0 {
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
