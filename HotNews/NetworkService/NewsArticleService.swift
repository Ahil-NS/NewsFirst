//
//  NewsArticle.swift
//  HotNews
//
//  Created by Ahil Ahilendran on 24/5/20.
//  Copyright © 2020 Ahil Ahilendran. All rights reserved.
//

import Foundation
import Moya

public enum NewsArticleService {
    case article(currentPage: Int, pageSize: Int = 20, query:String)
}

extension NewsArticleService: TargetType {
    
    public var baseURL: URL {
        switch self {
        case .article(let currenTpage, let pageSize,let query):
            return URL(string: "\( Common.baseURL)/everything?q=\(query)&apiKey=\(Common.apiKey)&page=\(currenTpage)&pageSize=\(pageSize)")!
        }
    }
    
    public var path: String {
        switch self {
        case .article: return Common.blank
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .article: return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case .article:
            return .requestPlain
        }
    }
    
    public var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
}

