//
//  NewsCategoryDataService.swift
//  HotNews
//
//  Created by Ahil Ahilendran on 24/5/20.
//  Copyright © 2020 Ahil Ahilendran. All rights reserved.
//

import Foundation

enum NewsCategory {
    case business
    case entertainment
    case general
    case health
    case science
    case sports
    case technology
    
    func getTitle() -> String {
        switch self {
        case .business:
            return "Business"
        case .entertainment:
            return "Entertainment"
        case .general:
            return "General"
        case .health:
            return "Health"
        case .science:
            return "Science"
        case .sports:
            return "Sports"
        case .technology:
            return "Technology"
        }
    }
}

class NewsCategoryDataService{
    static let instance = NewsCategoryDataService()
    
    private var newsCategories =  [NewsCategoryModel(title: NewsCategory.business.getTitle(), imageName: "business"),
                                   NewsCategoryModel(title: NewsCategory.entertainment.getTitle(), imageName: "entertainment"),
                                   NewsCategoryModel(title: NewsCategory.general.getTitle(), imageName: "general"),
                                   NewsCategoryModel(title: NewsCategory.health.getTitle(), imageName: "health"),
                                   NewsCategoryModel(title: NewsCategory.science.getTitle(), imageName: "science"),
                                   NewsCategoryModel(title: NewsCategory.sports.getTitle(), imageName: "sports"),
                                   NewsCategoryModel(title: NewsCategory.technology.getTitle(), imageName: "technology"),
    ]
    
    func getTechnologies() -> [NewsCategoryModel]{
        return newsCategories
    }
}

