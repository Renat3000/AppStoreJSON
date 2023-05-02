//
//  AppsHeaderHorizontalController.swift
//  AppStoreJSON
//
//  Created by Renat Nazyrov on 21.04.2023.
//

import UIKit

class AppsHeaderHorizontalController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout {
    
    //обязательно нужно создать cellId, зарегистрировать collectionView.register, задать количество ячеек numberOfItemsInSection и cellForItemAt. всё!
    let cellId = "cellId"
    var socialApps = [SocialApp]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(AppsHeaderCell.self, forCellWithReuseIdentifier: cellId)
            // теперь наш AppsHeaderHorizontalController наследует от HorizontalSnappingController
//        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
//            layout.scrollDirection = .horizontal
//        }
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 48, height: view.frame.height)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return .init(top: 0, left: 16, bottom: 0, right: 16)
//    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return socialApps.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppsHeaderCell
//        cell.backgroundColor = .red
        let app = self.socialApps[indexPath.item]
        cell.companyLabel.text = app.name
        cell.titleLable.text = app.tagline
        cell.imageView.sd_setImage(with: URL(string: app.imageUrl))
        return cell
    }
}
