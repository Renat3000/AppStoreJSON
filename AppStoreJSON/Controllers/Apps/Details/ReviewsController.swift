//
//  ReviewsController.swift
//  AppStoreJSON
//
//  Created by Renat Nazyrov on 09.05.2023.
//

import UIKit

class ReviewsController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout {
    let cellId = "cellId"
    var reviews: Reviews? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //цвет фона под ячейками
        collectionView.backgroundColor = .white
        
        collectionView.register(ReviewCell.self, forCellWithReuseIdentifier: cellId)
        // contentInset - distance that the content view is inset from the safe area or scroll view edge
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reviews?.feed.entry.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ReviewCell
//        цвет ячеек
//        cell.backgroundColor = .red
        
        let entry = self.reviews?.feed.entry[indexPath.item]
        cell.titleLabel.text = entry?.title.label
        cell.authorLabel.text = entry?.author.name.label
//        cell.starsLabel.text =
        cell.bodyLabel.text = entry?.content.label
        
        for (index, view) in cell.starsStackView.arrangedSubviews.enumerated() {
            if let ratingInt = Int(entry!.rating.label) {
                view.alpha = index >= ratingInt ? 0 : 1
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 48, height: view.frame.height)
    }
//        интервал между ячеек
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}
