//
//  NewsCategoryViewController.swift
//  HotNews
//
//  Created by Ahil Ahilendran on 24/5/20.
//  Copyright © 2020 Ahil Ahilendran. All rights reserved.
//

import UIKit

class NewsCategoryViewController: UIViewController {
    
    private(set) public var categories = [NewsCategoryModel]()
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initCategory()
    }
    
    func initCategory(){
        title = Common.hotNews
        categories = NewsCategoryDataService.instance.getTechnologies()
    }
}

extension NewsCategoryViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reuseIdentifier, for: indexPath) as? CategoryCell else{return CategoryCell()}
        
        cell.configure(with: categories[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "NewsSourceViewController") as! NewsSourceViewController
        secondViewController.category = getEnumCategory(title: categories[indexPath.row].title )
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = min(self.view.bounds.size.width, self.view.bounds.size.height) * 1.3
        return CGSize(width: self.view.bounds.size.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func getEnumCategory(title: String) -> NewsSource.Category {
        
        switch title {
        case NewsCategory.business.getTitle():
            return .business
        case NewsCategory.entertainment.getTitle():
            return .entertainment
        case NewsCategory.business.getTitle():
            return .general
        case NewsCategory.general.getTitle():
            return .business
        case NewsCategory.health.getTitle():
            return .health
        case NewsCategory.science.getTitle():
            return .science
        case NewsCategory.technology.getTitle():
            return .technology
        default:
            return .general
        }
    }
}
