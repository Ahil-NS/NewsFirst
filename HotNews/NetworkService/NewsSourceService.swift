//
//  NewsSource.swift
//  HotNews
//
//  Created by Ahil Ahilendran on 24/5/20.
//  Copyright © 2020 Ahil Ahilendran. All rights reserved.
//

import Foundation
import Moya

public enum NewsSourceService {
  case source
}
extension NewsSourceService: TargetType {
    
  public var baseURL: URL {
    switch self {
    case .source : return URL(string: "\(Common.baseURL)/sources?apiKey=\(Common.apiKey)")!
    }
  }
    
  public var path: String {
    switch self {
    case .source: return Common.blank
    }
  }
    
  public var method: Moya.Method {
    switch self {
    case .source: return .get
    }
  }

  public var sampleData: Data {
    return Data()
  }

 public var task: Task {
   switch self {
   case .source:
    return .requestPlain
   }
 }
    
  public var headers: [String: String]? {
    return ["Content-Type": "application/json"]
  }
  
  public var validationType: ValidationType {
    return .successCodes
  }
}


