//
//  NewsSourceResponse.swift
//  HotNews
//
//  Created by Ahil Ahilendran on 24/5/20.
//  Copyright © 2020 Ahil Ahilendran. All rights reserved.
//

import Foundation

public struct NewsSource: Codable {
    public struct Response: Codable {
        let status: String
        let sources: [Source]
    }

    // MARK: - Source
    struct Source: Codable {
        let id, name, description: String
        let url: String
        let category: Category
        let language, country: String

    }

    enum Category: String, Codable {
        case business
        case entertainment
        case general
        case health
        case science
        case sports
        case technology
    }
}
