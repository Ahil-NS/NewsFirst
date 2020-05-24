//
//  CategoryCell.swift
//  HotNews
//
//  Created by Ahil Ahilendran on 24/5/20.
//  Copyright © 2020 Ahil Ahilendran. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {
   
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryImageView: UIImageView!
     
    
    static var reuseIdentifier: String {
           return String(describing: CategoryCell.self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        containerView.layer.cornerRadius = 20
        containerView.layer.masksToBounds = true
        
    }
    
    func configure(with vm: NewsCategoryModel?) {
         if let vm = vm {
            categoryLabel.text = vm.title
            categoryImageView.image = UIImage(named: vm.imageName)
         }
     }
    
}
