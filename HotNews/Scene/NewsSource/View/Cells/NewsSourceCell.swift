//
//  NewsSourceCell.swift
//  HotNews
//
//  Created by Ahil Ahilendran on 23/5/20.
//  Copyright © 2020 Ahil Ahilendran. All rights reserved.
//

import UIKit

class NewsSourceCell: UITableViewCell {
    
    static var reuseIdentifier: String {
            return String(describing: NewsSourceCell.self)
     }
    
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var vm: NewsSourceCellVM? {
        didSet {
            urlLabel.text = vm?.url
            nameLabel.text = vm?.name
            descriptionLabel.text = vm?.description
        }
    }
}
