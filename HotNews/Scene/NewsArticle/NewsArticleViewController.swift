//
//  NewsArticleViewController.swift
//  HotNews
//
//  Created by Ahil Ahilendran on 23/5/20.
//  Copyright © 2020 Ahil Ahilendran. All rights reserved.
//

import Foundation
import Moya

class NewsArticleViewController: UIViewController {
    
    var output: NewsArticleInteractorInput?
    var router: PPArticleRouterProtocol?
    var cellVMs: [NewsArticleCellVM] = []
    var searchVM: [NewsArticleCellVM] = []
    var sourceId: String = Common.blank
    var isSearch = false
    
    
    @IBOutlet weak var indiactorView: UIActivityIndicatorView!
    @IBOutlet weak var articleTableView: UITableView!
    @IBOutlet weak var articleSearchBar: UISearchBar!
    @IBOutlet weak var errorLabel: UILabel!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    // MARK: - Configurator
    private func configure(configurator: PPBaseConfig = NewsArticleConfigurator.sharedInstance) {
        configurator.configure(viewController: self)
    }
    
    deinit {
        //dealloc called
    }
    
    override func viewDidLoad() {
        setupViews()
        output?.getAllArticle(searchId: sourceId)
    }
    
    func setupViews() {
        articleTableView.register(UINib(nibName: "NewsArticleCell", bundle: nil),
                                  forCellReuseIdentifier: NewsArticleCell.reuseIdentifier)
        indiactorView.startAnimating()
        indiactorView.hidesWhenStopped = true
      
        articleTableView.delegate = self
        articleTableView.dataSource = self
        articleTableView.prefetchDataSource = self
        articleTableView.isHidden = true
        errorLabel.isHidden = true
        title = Common.newsArticle
        errorLabel.text = Common.noResultFound
    }
}

extension NewsArticleViewController: NewsArticlePresenterOutput {
    func displayPlayList(vm: [NewsArticleCellVM]) {
        DispatchQueue.main.async { [weak self] in
            self?.cellVMs = vm
            self?.indiactorView.stopAnimating()
            self?.articleTableView.reloadData()
            
            if self?.cellVMs.count == 0 {
                self?.errorLabel.isHidden = false
                self?.articleTableView.isHidden = true
            }else {
                self?.errorLabel.isHidden = true
                self?.articleTableView.isHidden = false
                
            }
        }
    }
    
    func displayErrorMessage(message: String) {
        self.indiactorView.stopAnimating()
        let alert = UIAlertController(title: Common.errorTitle, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Common.Okay, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension NewsArticleViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearch {
            return searchVM.count
        } else {
            return cellVMs.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsArticleCell.reuseIdentifier,
                                                 for: indexPath) as! NewsArticleCell
        if isSearch {
            cell.configure(with: searchVM[indexPath.row])
        } else {
            if isLoadingCell(for: indexPath) {
                cell.configure(with: .none)
            } else {
                cell.configure(with: cellVMs[indexPath.row])
            }
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        guard let url = cellVMs[indexPath.row].url else { return }
        let webVC = NewsWebViewController(url: url)
        navigationController?.pushViewController(webVC, animated: true)
    }
}



extension NewsArticleViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if let loadCellIndexPath =  tableView.indexPathsForVisibleRows?.last {
            if isLoadingCell(for: loadCellIndexPath) {
                output?.getAllArticle(searchId: sourceId)
            }
        }
    }
}

private extension NewsArticleViewController {
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= cellVMs.count - 1
    }
}

extension NewsArticleViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isSearch = false
            reloadTableView()
        } else {
            isSearch = true
            searchVM = searchText.isEmpty ? cellVMs :
                cellVMs.filter{($0.description?.contains(searchText) ?? false)}
            
            if searchVM.count == 0 {
                articleTableView.isHidden = true
                errorLabel.isHidden = false
            } else {
                articleTableView.isHidden = false
                errorLabel.isHidden = true
            }
            self.articleTableView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearch = false
        reloadTableView()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        reloadTableView()
    }
    
    func reloadTableView() {
        articleTableView.isHidden = false
        articleSearchBar.resignFirstResponder()
        self.articleTableView.reloadData()
    }
}
