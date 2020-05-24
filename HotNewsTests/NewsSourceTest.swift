//
//  NewsSourceTest.swift
//  HotNewsTests
//
//  Created by Ahil Ahilendran on 24/5/20.
//  Copyright © 2020 Ahil Ahilendran. All rights reserved.
//

import Foundation
import XCTest
@testable import HotNews

class NewsSourceTest: XCTestCase {
    
    var viewController: NewsSourceViewController!
    
    override func setUp() {
        super.setUp()
        setupViewController()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewController = nil
        super.tearDown()
    }
    
    
    func setupViewController()
    {
        viewController = NewsSourceViewController()
    }
    
    func testSourceApiselectedCategory() {
        // Given
        let interactor = NewsSourceMockInteractor()
        viewController.output = interactor
        interactor.getAllNewsSource(newsCatgegory: .business)
      XCTAssertEqual(interactor.selectedCategory, NewsSource.Category.business, "SelectedCategory NewsSource.Category.busines")
    }
    
    func testAllNewsSourceApiCalled() {
        // Given
        let interactor = NewsSourceMockInteractor()
        viewController.output = interactor
        interactor.getAllNewsSource(newsCatgegory: .business)
        XCTAssertEqual(interactor.getAllCalled, true, "All News Source Api Called")
    }
    
}


class NewsSourceMockPresenter: NewsSourcePresenterInput {
    var dispalyErrorCalled = false
    var presentDataCalled = false
    
    func displayErrorMessage(message: String) {
        dispalyErrorCalled = true
    }
    
    func presentData(data: [NewsSource.Source]) {
        presentDataCalled = true
    }
}

class NewsSourceMockInteractor: NewsSourceInteractorInput {
    
    var getAllCalled = false
     var selectedCategory: NewsSource.Category?
    
    func getAllNewsSource(newsCatgegory: NewsSource.Category) {
        getAllCalled = true
        selectedCategory = newsCatgegory
    }
}

class NewsSourceMockInteractorA: NewsSourceApiProtocol {
    var isApiSuccess = false
    var isApiFaliure = false
    func apiResponseSuccess(response: NewsSource.Response?) {
        isApiSuccess = true
    }
    func apiResponseFailure() {
        isApiFaliure = true
    }
}

class NewsSourceMockApiWorker: NewsSourceApiWorkerProtocol {
    var apiDelegate: NewsSourceApiProtocol?
    
    func getNewsSource() {
    }
}
