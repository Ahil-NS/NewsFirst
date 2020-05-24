//
//  NewsCategoryModel.swift
//  HotNews
//
//  Created by Ahil Ahilendran on 24/5/20.
//  Copyright © 2020 Ahil Ahilendran. All rights reserved.
//

import Foundation


struct NewsCategoryModel{
    private(set) public var title: String
    private(set) public var imageName: String
    
    init(title: String, imageName: String ) {
        self.title = title
        self.imageName = imageName
    }
    
}

