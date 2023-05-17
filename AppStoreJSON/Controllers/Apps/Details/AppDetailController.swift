//
//  AppDetailController.swift
//  AppStoreJSON
//
//  Created by Renat Nazyrov on 03.05.2023.
//

import UIKit

class AppDetailController: BaseListController, UICollectionViewDelegateFlowLayout {
    
    // теперь AppDetailController нужно инициализировать вот так AppDetailController(appId: appId):
    fileprivate let appId: String
    
    //dependency injection constructor
    init(appId: String) {
        self.appId = appId
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//let's make app a global variable
    var app: Result?
    var reviews: Reviews?
        
    let detailCellId = "detailCellId"
    let previewCellId = "previewCellId"
    let reviewCellId = "reviewCellId"
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(AppDetailCell.self, forCellWithReuseIdentifier: detailCellId)
        collectionView.register(PreviewCell.self, forCellWithReuseIdentifier: previewCellId)
        collectionView.register(ReviewRowCell.self, forCellWithReuseIdentifier: reviewCellId)
        //чтобы не показывать шапку в капсе
        navigationItem.largeTitleDisplayMode = .never
        fetchData()
    
    }
    
    fileprivate func fetchData() {
        let urlString = "https://itunes.apple.com/lookup?id=\(appId)"
        Service.shared.fetchGenericJSONData(urlString: urlString) { (result: SearchResult?, err) in
            let app = result?.results.first
            self.app = app
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            // .first потому что должны взять первый результат из поиска (и хоупфулли - единственный)
//                print(result?.results.first?.releaseNotes ?? "shiiiet turn on vpn")
        }
        
        let reviewsUrl = "https://itunes.apple.com/us/rss/customerreviews/id=\(appId)/sortby=mostrecent/json"
//            print(reviewsUrl)
        Service.shared.fetchGenericJSONData(urlString: reviewsUrl) { (reviews: Reviews?, err) in
            
            if let err = err {
                print("Failed to decode reviews:", err)
                return
            }
            
            self.reviews = reviews
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
//                reviews?.feed.entry.forEach({ (entry) in
//                    print(entry.title.label, entry.author.name.label, entry.content.label)
//                })
            
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //поменяли на 2 тк теперь 2 ячейки
        //поменяли на 3 тк теперь 3 ячейки (+отзывы)
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // выше мы прогружаем 2 ячейки, чтобы они не были двумя копиями, а разными, их надо закастовать как 2 разные ячейки. делаем это через простое условие
        if indexPath.item == 0  {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: detailCellId, for: indexPath) as! AppDetailCell
            
            cell.app = app
            return cell
        } else if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: previewCellId, for: indexPath) as! PreviewCell
            
            cell.horizontalController.app = self.app
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reviewCellId, for: indexPath) as! ReviewRowCell
            cell.reviewsController.reviews = self.reviews
            return cell
        }
        
    }
    //для этой функции нужен протокол UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height: CGFloat = 250
        
        if indexPath.item == 0  {
            
            //проблема, высота в 300 юнитов ниже у высоты - слишком мало. нам по хорошему нужен autoresizable контент
            //        return .init(width: view.frame.width, height: 300)
            //надо рассчитать нужный размер ячейки:
            let dummyCell = AppDetailCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 1000))
            // мы должны прописать в нашем dummyCell все элементы которые должны быть у нас на экране, чтобы он посчитал нужный размер ячейки:
            //        dummyCell.nameLabel.text = app?.trackName
            //        dummyCell.appIconImageView.sd_setImage(with: URL(string: app?.artworkUrl100 ?? ""))
            //        dummyCell.releaseNotesLabel.text = app?.releaseNotes
            //        dummyCell.priceButton.setTitle(app?.formattedPrice, for: .normal)
            //      но чтобы сэкономить время мы можем сделать вот так:
            
            dummyCell.app = app
            //функция ниже нужна в любом случае:
            dummyCell.layoutIfNeeded()
            
            let estimatedSize = dummyCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 1000))
            height = estimatedSize.height
        } else if indexPath.item == 1 {
            height = 500
        } else {
            height = 250
        }
        return .init(width: view.frame.width, height: height)

    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 0, bottom: 16, right: 0)
    }
    
}
