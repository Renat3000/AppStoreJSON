//
//  AppsSearchController.swift
//  AppStoreJSON
//
//  Created by Renat Nazyrov on 25.03.2023.
//

import UIKit
import SDWebImage

class AppsSearchController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let cellId = "id1234"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: cellId)
        fetchITunesApps()
        
    }
    
    fileprivate var appResults = [Result]()
    
    fileprivate func fetchITunesApps () {
        
        Service.shared.fetchApps { (results, err) in
            
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
