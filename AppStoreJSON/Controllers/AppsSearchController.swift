//
//  AppsSearchController.swift
//  AppStoreJSON
//
//  Created by Renat Nazyrov on 25.03.2023.
//

import UIKit
import SDWebImage

class AppsSearchController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    fileprivate let cellId = "id1234"
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    fileprivate let enterSearchTermLabel: UILabel = {
        let label = UILabel()
        label.text = "Please enter search term above..."
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.addSubview(enterSearchTermLabel)
        enterSearchTermLabel.fillSuperview(padding: .init(top: 50, left: 50, bottom: 0, right: 50))
        setupSearchBar()
//        fetchITunesApps()
    }
    
    fileprivate func setupSearchBar () {
        definesPresentationContext = true
        navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
//        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
// timer for search-fetching delay
    var timer: Timer?
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        print(searchText)
// need to add delay = throttle the search
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            Service.shared.fetchApps(searchTerm: searchText) { res, err in
                self.appResults = res
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        })
        
    }
    
    fileprivate var appResults = [Result]()
    
    fileprivate func fetchITunesApps () {
        
        Service.shared.fetchApps(searchTerm: "twitter") { (results, err) in
            
            if let err = err {
                print("Failed fetching apps:", err)
                return
            }
//          self.appResults = searchResult.results
//          searchResult.results.forEach({print($0.trackName, $0.primaryGenreName)})
            self.appResults = results
//          UICollectionView.reloadData() must be used from main thread only, поэтому используем функцию ниже
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
//        print("Finished fetching apps from controller")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 350)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        enterSearchTermLabel.isHidden = appResults.count != 0
//      заменили int на appResults. Мы же можем их посчитать через count
        return appResults.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchResultCell
//        cell.nameLabel.text = "Here is my app name"
//        можно indexPath.row но appleTeam рекомендует в UICollectionViewController использовать item. А в TableView уже .row
        cell.appResult = appResults[indexPath.item]
        return cell
    }
    
    
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
