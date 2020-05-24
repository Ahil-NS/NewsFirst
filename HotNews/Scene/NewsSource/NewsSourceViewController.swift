//
//  NewsSourceViewController.swift
//  HotNews
//
//  Created by Ahil Ahilendran on 23/5/20.
//  Copyright © 2020 Ahil Ahilendran. All rights reserved.
//

import Foundation
import Moya


class NewsSourceViewController: UIViewController {
    
    var output: NewsSourceInteractorInput?
    var router: PPSourceRouterProtocol?
    private var cellVMs: [NewsSourceCellVM] = []
    private var searchVM: [NewsSourceCellVM] = []
    var category: NewsSource.Category?
    var isSearch = false
    
    @IBOutlet weak var sourceSearchBar: UISearchBar!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var sourceTableView: UITableView!
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    // MARK: - Configurator
    private func configure(configurator: PPBaseConfig = PCRHomeConfigurator.sharedInstance) {
        configurator.configure(viewController: self)
    }
    
    deinit {
        //dealloc called
    }
    
    override func viewDidLoad() {
        setupViews()
        output?.getAllNewsSource(newsCatgegory: category ?? .general)
    }
    
    func setupViews() {
        sourceTableView.register(UINib(nibName: "NewsSourceCell", bundle: nil),
                                 forCellReuseIdentifier: NewsSourceCell.reuseIdentifier)
        indicatorView.startAnimating()
        indicatorView.hidesWhenStopped = true
        sourceTableView.isHidden = true
        errorLabel.isHidden = true
        sourceTableView.delegate = self
        sourceTableView.dataSource = self
        title = Common.newsSource
        
    }
}

extension NewsSourceViewController: NewsSourcePresenterOutput {
    func displayPlayList(vm: [NewsSourceCellVM]) {
        DispatchQueue.main.async { [weak self] in
            self?.indicatorView.stopAnimating()
            self?.sourceTableView.isHidden = false
            self?.cellVMs = vm
            self?.sourceTableView.reloadData()
        }
    }
    
    func displayErrorMessage(message: String) {
        self.indicatorView.stopAnimating()
        let alert = UIAlertController(title: Common.errorTitle, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Common.Okay, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}



extension NewsSourceViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearch {
            return searchVM.count
        } else {
            return cellVMs.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:  NewsSourceCell.reuseIdentifier,
                                                       for: indexPath) as? NewsSourceCell else { return UITableViewCell() }
        if isSearch {
            cell.vm = searchVM[indexPath.row]
        } else {
            cell.vm = cellVMs[indexPath.row]
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        sourceSearchBar.resignFirstResponder()
        tableView.deselectRow(at: indexPath, animated: false)
        
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "NewsArticleViewController") as! NewsArticleViewController
        
        var sourceId:String = Common.blank
        if isSearch {
            sourceId = searchVM[indexPath.row].id ?? Common.blank
        } else {
            sourceId = cellVMs[indexPath.row].id ?? Common.blank
        }
        secondViewController.sourceId = sourceId
        self.navigationController?.pushViewController(secondViewController, animated: true)
        
    }
}

// MARK: - SearchBar Delegate Method
extension NewsSourceViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isSearch = false
            reloadTableView()
        } else {
            isSearch = true
            searchVM = searchText.isEmpty ? cellVMs :
                cellVMs.filter{($0.description?.contains(searchText) ?? false)}
            
            if searchVM.count == 0 {
                sourceTableView.isHidden = true
                errorLabel.isHidden = false
            } else {
                sourceTableView.isHidden = false
                errorLabel.isHidden = true
            }
            self.sourceTableView.reloadData()
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
        sourceTableView.isHidden = false
        sourceSearchBar.resignFirstResponder()
        self.sourceTableView.reloadData()
    }
}
