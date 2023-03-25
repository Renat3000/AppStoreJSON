//
//  AppsSearchController.swift
//  AppStoreJSON
//
//  Created by Renat Nazyrov on 25.03.2023.
//

import UIKit

class AppsSearchController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
    }
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
