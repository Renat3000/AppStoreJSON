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
                let app = result?.results.first
                self.app = app
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                // .first потому что должны взять первый результат из поиска (и хоупфулли - единственный)
//                print(result?.results.first?.releaseNotes ?? "shiiiet turn on vpn")
            }
        }
    }
//let's make app a global variable
    var app: Result?
    
    let detailCellId = "detailCellId"
    let previewCellId = "previewCellId"
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(AppDetailCell.self, forCellWithReuseIdentifier: detailCellId)
        collectionView.register(PreviewCell.self, forCellWithReuseIdentifier: previewCellId)
        //чтобы не показывать шапку в капсе
        navigationItem.largeTitleDisplayMode = .never
    
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //поменяли на 2 тк теперь 2 ячейки
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // выше мы прогружаем 2 ячейки, чтобы они не были двумя копиями, а разными, их надо закастовать как 2 разные ячейки. делаем это через простое условие
        if indexPath.item == 0  {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: detailCellId, for: indexPath) as! AppDetailCell
            
            cell.app = app
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: previewCellId, for: indexPath) as! PreviewCell
            
            cell.horizontalController.app = self.app
            return cell
        }
        
    }
    //для этой функции нужен протокол UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
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
            return .init(width: view.frame.width, height: estimatedSize.height)
        } else {
            return .init(width: view.frame.width, height: 500)
        }
    }
    
    
}
