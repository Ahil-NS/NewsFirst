//
//  NewsSourceRouter.swift
//  HotNews
//
//  Created by Ahil Ahilendran on 23/5/20.
//  Copyright © 2020 Ahil Ahilendran. All rights reserved.
//

import Foundation

import UIKit
protocol PPSourceRouterProtocol {

    var viewController: NewsSourceViewController? { get }
}

final class NewsSourceRouter {

    weak var viewController: NewsSourceViewController?

    // MARK: - Initializers

    init(viewController: NewsSourceViewController?) {
        self.viewController = viewController
    }
}

// MARK: - PPHomeRouterProtocol
extension NewsSourceRouter: PPSourceRouterProtocol {
    // MARK: - Navigation
    func navigateToDetailVC() {
    }
    
}

