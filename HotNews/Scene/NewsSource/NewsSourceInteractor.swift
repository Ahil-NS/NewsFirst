//
//  NewsSourceInteractor.swift
//  HotNews
//
//  Created by Ahil Ahilendran on 23/5/20.
//  Copyright © 2020 Ahil Ahilendran. All rights reserved.
//

import Foundation
import Alamofire

protocol NewsSourceInteractorInput {
    func getAllNewsSource(newsCatgegory: NewsSource.Category)
}

final class NewsSourceInteractor {
    
    let output: NewsSourcePresenterInput
    let apiWorker: NewsSourceApiWorker = NewsSourceApiWorker()
    var maiCellVMs: [NewsSource.Source] = []
    var selectedCategory: NewsSource.Category?
    
    // MARK: - Initializers
    init(output: NewsSourcePresenterInput) {
        self.output = output
        apiWorker.apiDelegate = self
    }
}

// MARK: - PPHomeInteractorInput
extension NewsSourceInteractor: NewsSourceInteractorInput {
    func getAllNewsSource(newsCatgegory: NewsSource.Category) {
        selectedCategory = newsCatgegory
        apiWorker.getNewsSource()
    }
}

extension  NewsSourceInteractor: NewsSourceApiProtocol {
    func apiResponseSuccess(response: NewsSource.Response?) {
        if let data = response {
            data.sources.forEach{ article in
                maiCellVMs.append(article)
            }
            let filter = maiCellVMs.filter{$0.category == selectedCategory}
            self.output.presentData(data: filter)
        }
    }
    
    func apiResponseFailure() {
        self.output.displayErrorMessage(message: Common.errorMessage)
    }
}
