//
//  NewsArticleRouter.swift
//  HotNews
//
//  Created by Ahil Ahilendran on 23/5/20.
//  Copyright © 2020 Ahil Ahilendran. All rights reserved.
//

import UIKit
protocol PPArticleRouterProtocol {
    var viewController: NewsArticleViewController? { get }
}

final class NewsArticleRouter {

    weak var viewController: NewsArticleViewController?

    // MARK: - Initializers

    init(viewController: NewsArticleViewController?) {
        self.viewController = viewController
    }
}

// MARK: - PPHomeRouterProtocol
extension NewsArticleRouter: PPArticleRouterProtocol {
    // MARK: - Navigation
    func navigateToDetailVC() {

    }
    
}

