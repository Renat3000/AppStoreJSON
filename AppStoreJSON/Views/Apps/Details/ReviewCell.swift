//
//  ReviewCell.swift
//  AppStoreJSON
//
//  Created by Renat Nazyrov on 09.05.2023.
//

import UIKit

class ReviewCell: UICollectionViewCell {
    
    let titleLabel = UILabel(text: "Review Label", font: .boldSystemFont(ofSize: 18))
    let authorLabel = UILabel(text: "Author", font: .systemFont(ofSize: 18))
    let starsLable = UILabel(text: "★", font: .systemFont(ofSize: 14))
    let bodyLabel = UILabel(text: "Body text\nAnd Body text\nAnd Body text", font: .systemFont(ofSize: 16), numberOfLines: 0)
//  https://itunes.apple.com/us/rss/customerreviews/id=389801252/json
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        backgroundColor = .systemGray6
        layer.cornerRadius = 16
        clipsToBounds = true
        
        let stackView = VerticalStackView(arrangedSubViews: [
            UIStackView(arrangedSubviews: [titleLabel, UIView(), authorLabel]),
            starsLable,
            bodyLabel
        ], spacing: 12)
        
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 20, left: 20, bottom: 20, right: 20))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
