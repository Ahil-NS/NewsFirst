//
//  NewsArticleConfigurator.swift
//  HotNews
//
//  Created by Ahil Ahilendran on 23/5/20.
//  Copyright © 2020 Ahil Ahilendran. All rights reserved.
//

import UIKit


final class NewsArticleConfigurator: PPBaseConfig {

    // MARK: - Singleton
    static let sharedInstance: NewsArticleConfigurator = NewsArticleConfigurator()

    // MARK: - Configuration
    func configure(viewController: UIViewController)  {
        if let viewControllerUW = viewController as? NewsArticleViewController {
            let router = NewsArticleRouter(viewController: viewControllerUW)
            let presenter = NewsArticlePresenter(output: viewControllerUW)
            let interactor = NewsArticleInteractor(output: presenter)
            viewControllerUW.output = interactor
            viewControllerUW.router = router
        }
    }
}
