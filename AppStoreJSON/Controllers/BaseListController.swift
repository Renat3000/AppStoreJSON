//
//  BaseListController.swift
//  AppStoreJSON
//
//  Created by Renat Nazyrov on 15.04.2023.
//

import UIKit

class BaseListController: UICollectionViewController {
    //чтобы не крэшилось с ошибкой non-nil layout нужно добавить эти строки ниже:
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
