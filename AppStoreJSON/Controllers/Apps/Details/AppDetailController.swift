//
//  AppDetailController.swift
//  AppStoreJSON
//
//  Created by Renat Nazyrov on 03.05.2023.
//

import UIKit

class AppDetailController: BaseListController, UICollectionViewDelegateFlowLayout {
    
    var appId: String! {
        didSet {
//            print("here's my appId", appId as Any)
            let urlString = "https://itunes.apple.com/lookup?id=\(appId ?? "")"
            Service.shared.fetchGenericJSONData(urlString: urlString) { (result: SearchResult?, err) in
                // .first потому что должны взять первый результат из поиска (и хоупфулли - единственный)
//                print(result?.results.first?.releaseNotes ?? "shiiiet turn on vpn")
            }
        }
    }

    let detailCellId = "detailCellId"
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(AppDetailCell.self, forCellWithReuseIdentifier: detailCellId)
        //чтобы не показывать шапку в капсе
        navigationItem.largeTitleDisplayMode = .never
    
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: detailCellId, for: indexPath) as! AppDetailCell
        return cell
    }
    //для этой функции нужен протокол UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }
    
    
}
