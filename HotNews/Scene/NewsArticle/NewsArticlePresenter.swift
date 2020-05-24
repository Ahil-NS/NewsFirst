//
//  NewsArticlePresenter.swift
//  HotNews
//
//  Created by Ahil Ahilendran on 23/5/20.
//  Copyright © 2020 Ahil Ahilendran. All rights reserved.
//

import Foundation

protocol NewsArticlePresenterInput {
    func displayErrorMessage(message: String)
    func presentData(data: [GettNewsSource.Article])
}

protocol NewsArticlePresenterOutput: AnyObject {
    func displayPlayList(vm: [NewsArticleCellVM])
    func displayErrorMessage(message: String)
}

final class NewsArticlePresenter {
    private(set) weak var output: NewsArticlePresenterOutput?
    
    init(output: NewsArticlePresenterOutput) {
        self.output = output
    }
}

extension NewsArticlePresenter: NewsArticlePresenterInput {
    func presentData(data: [GettNewsSource.Article]) {
        var cellVM: [NewsArticleCellVM] = []
        data.forEach{ item in
            let vm = NewsArticleCellVM(author: item.author, title: item.title, description: item.description, url: item.url, imageUrl: item.urlToImage)
            cellVM.append(vm)
        }
        output?.displayPlayList(vm: cellVM)
    }
    
    func displayErrorMessage(message: String) {
        output?.displayErrorMessage(message: message)
    }
}
