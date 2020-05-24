//
//  NewsArticleInteractor.swift
//  HotNews
//
//  Created by Ahil Ahilendran on 23/5/20.
//  Copyright © 2020 Ahil Ahilendran. All rights reserved.
//

import Foundation
import Alamofire

protocol NewsArticleInteractorInput {
    func getAllArticle(searchId: String)
}

final class NewsArticleInteractor {
    
    let output: NewsArticlePresenterInput
    let apiWorker: NewsArticleApiWorker = NewsArticleApiWorker()
    
    var mainData: [GettNewsSource.Article] = []
    
    private var currentPage = 1
    private var total = 0
    private var isFetchInProgress = false
    
    
    // MARK: - Initializers
    init(output: NewsArticlePresenterInput) {
        self.output = output
        apiWorker.apiDelegate = self
    }
}

// MARK: - PPHomeInteractorInput
extension NewsArticleInteractor: NewsArticleInteractorInput {

    func getAllArticle(searchId: String) {
        guard !isFetchInProgress else {
          return
        }
        isFetchInProgress = true
        apiWorker.getArticle(currentPage: self.currentPage, query: searchId)
    }
}


extension  NewsArticleInteractor: ArticleApiProtocol {
    func apiResponseSuccess(response: GettNewsSource.Response?) {
        if let data = response {
            data.articles?.forEach{ article in
                mainData.append(article)
            }
            self.output.presentData(data: mainData)
        }
         self.currentPage += 1
         self.isFetchInProgress = false
    }
    
    func apiResponseFailure() {
        self.isFetchInProgress = false
        self.output.displayErrorMessage(message: Common.errorMessage)
    }
}
