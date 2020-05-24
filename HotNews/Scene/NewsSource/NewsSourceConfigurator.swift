//
//  NewsSourceConfigurator.swift
//  HotNews
//
//  Created by Ahil Ahilendran on 23/5/20.
//  Copyright © 2020 Ahil Ahilendran. All rights reserved.
//

import UIKit

final class PCRHomeConfigurator: PPBaseConfig {
    
    // MARK: - Singleton
    static let sharedInstance: PCRHomeConfigurator = PCRHomeConfigurator()
    
    // MARK: - Configuration
    func configure(viewController: UIViewController)  {
        
        if let viewControllerUW = viewController as? NewsSourceViewController {
            let router = NewsSourceRouter(viewController: viewControllerUW)
            let presenter = NewsSourcePresenter(output: viewControllerUW)
            let interactor = NewsSourceInteractor(output: presenter)
            viewControllerUW.output = interactor
            viewControllerUW.router = router
        }
    }
}

typealias Conf = PConfigurator

protocol PPBaseConfig {
    func configure(viewController: UIViewController)
}
class PConfigurator {
    private static var privateShared: PConfigurator = PConfigurator()
    static let shared: PConfigurator = {
        return privateShared
    }()
}
