//
//  NewsArticleResponse.swift
//  HotNews
//
//  Created by Ahil Ahilendran on 24/5/20.
//  Copyright © 2020 Ahil Ahilendran. All rights reserved.
//

import Foundation

public struct GettNewsSource: Codable {
    
    public struct Response: Codable {
        let status: String?
        let totalResults: Double?
        var articles: [Article]?
    }
    
    // MARK: - Article
    struct Article: Codable {
        let source: Source?
        let author: String?
        let title, description: String?
        let url: String?
        let urlToImage: String?
        let publishedAt: String?
        let content: String?
        
    }
    
    // MARK: - Source
    struct Source: Codable {
        let id: String?
        let name: String?
    }    
}


