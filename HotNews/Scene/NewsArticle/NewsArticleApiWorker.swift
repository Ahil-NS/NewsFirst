//
//  HanumaApiWorker.swift
//  HotNews
//
//  Created by Ahil Ahilendran on 24/5/20.
//  Copyright © 2020 Ahil Ahilendran. All rights reserved.
//

import Foundation
import Moya

public protocol ArticleApiProtocol: class {
    func apiResponseSuccess(response: GettNewsSource.Response?)
    func apiResponseFailure()
}

public protocol ArticleApiWorkerProtocol {
    var apiDelegate: ArticleApiProtocol? {get set}
    func getArticle(currentPage: Int, query: String)
}

public class NewsArticleApiWorker: ArticleApiWorkerProtocol {
    
    public weak var apiDelegate: ArticleApiProtocol?
    let provider = MoyaProvider<NewsArticleService>()
    public init() {}
    
    public func getArticle(currentPage: Int, query: String) {
        provider.request(.article(currentPage: currentPage, query: query)) { [weak self] result in
                 guard let self = self else { return }
                 switch result {
                 case .success(let response):
                   do {
                    let marvelResponse  = try? JSONDecoder().decode(GettNewsSource.Response.self, from: response.data)
                    self.apiDelegate?.apiResponseSuccess(response: marvelResponse)
                   }
                 case .failure:
                    self.apiDelegate?.apiResponseFailure()
                   break
                 }
               }
    }
}
