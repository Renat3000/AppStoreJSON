//
//  AppsSearchController.swift
//  AppStoreJSON
//
//  Created by Renat Nazyrov on 25.03.2023.
//

import UIKit

class AppsSearchController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let cellId = "id1234"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: cellId)
    fetchITunesApps()
        
    }
    
    fileprivate func fetchITunesApps () {
        let urlString = "https://itunes.apple.com/search?term=instagram&entity=software"
            // fetch data from internet
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, resp, err in
            
            if let err = err {
                print("failed to fetch apps:", err)
                return
            }
            // success
//            print(String(data: data!, encoding: .utf8))
            
            guard let data = data else { return }
            
            do {
                let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
//                print(searchResult)
                
                searchResult.results.forEach({print($0.trackName, $0.primaryGenreName)})
                
            } catch let jsonErr {
                print("Failed to decode json:", jsonErr)
            }
            
            
        }.resume() // fires off the request 
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 350)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchResultCell
        cell.nameLabel.text = "Here is my app name"
        return cell
    }
    
    
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
