//
//  NewsArticleCell.swift
//  HotNews
//
//  Created by Ahil Ahilendran on 23/5/20.
//  Copyright © 2020 Ahil Ahilendran. All rights reserved.
//

import UIKit
import Kingfisher

class NewsArticleCell: UITableViewCell {
    
    static var reuseIdentifier: String {
        return String(describing: NewsArticleCell.self)
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var dataView: UIStackView!
    
    @IBOutlet weak var indiactor: UIActivityIndicatorView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        configure(with: .none)
    }
    
    func configure(with vm: NewsArticleCellVM?) {
        if let vm = vm {
            
            indiactor.stopAnimating()
            loadingView.alpha = 0
            dataView.alpha = 1
            titleLabel.text = vm.title
            authorLabel.text = vm.author
            descriptionLabel.text = vm.description
            
            if let url = URL(string: (vm.imageUrl ?? "")) {
                articleImage.kf.setImage(with: url)
            }
        } else {
            loadingView.alpha = 1
            dataView.alpha = 0
            indiactor.startAnimating()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        indiactor.hidesWhenStopped = true
        articleImage.layer.cornerRadius = 20
        articleImage.layer.masksToBounds = true
    }
}


