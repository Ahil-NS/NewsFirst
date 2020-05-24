//
//  NewsSourcePresenter.swift
//  HotNews
//
//  Created by Ahil Ahilendran on 23/5/20.
//  Copyright © 2020 Ahil Ahilendran. All rights reserved.
//

import Foundation

protocol NewsSourcePresenterInput {
    func displayErrorMessage(message: String)
    func presentData(data: [NewsSource.Source])
}

protocol NewsSourcePresenterOutput: AnyObject {
    func displayPlayList(vm: [NewsSourceCellVM])
    func displayErrorMessage(message: String)
}

final class NewsSourcePresenter {

    private(set) weak var output: NewsSourcePresenterOutput?
    
    init(output: NewsSourcePresenterOutput) {
        self.output = output
    }
}

extension NewsSourcePresenter: NewsSourcePresenterInput {
    func presentData(data: [NewsSource.Source]) {
        
        var cellVM: [NewsSourceCellVM] = []
        data.forEach{ item in
            let vm = NewsSourceCellVM(id: item.id, name: item.name, description: item.description, url: item.url)
            cellVM.append(vm)
        }
        output?.displayPlayList(vm: cellVM)
    }
    
    func displayErrorMessage(message: String) {
        output?.displayErrorMessage(message: message)
    }
}
