//
//  NewsSourceApiWorker.swift
//  HotNews
//
//  Created by Ahil Ahilendran on 23/5/20.
//  Copyright © 2020 Ahil Ahilendran. All rights reserved.
//

import Foundation
import Moya

public protocol NewsSourceApiProtocol: class {
    func apiResponseSuccess(response: NewsSource.Response?)
    func apiResponseFailure()
}

public protocol NewsSourceApiWorkerProtocol {
    var apiDelegate: NewsSourceApiProtocol? {get set}
    func getNewsSource()
}

public class NewsSourceApiWorker: NewsSourceApiWorkerProtocol {
    
    public weak var apiDelegate: NewsSourceApiProtocol?
    let provider = MoyaProvider<NewsSourceService>()
    public init() {}
    
    public func getNewsSource() {
        provider.request(.source) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                do {
                    let marvelResponse  = try? JSONDecoder().decode(NewsSource.Response.self, from: response.data)
                    self.apiDelegate?.apiResponseSuccess(response: marvelResponse)
                }
            case .failure:
                self.apiDelegate?.apiResponseFailure()
                break
            }
        }
    }
}
