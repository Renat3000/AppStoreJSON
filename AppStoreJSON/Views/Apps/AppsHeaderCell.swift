//
//  AppsHeaderCell.swift
//  AppStoreJSON
//
//  Created by Renat Nazyrov on 21.04.2023.
//

import UIKit

class AppsHeaderCell: UICollectionViewCell {
    
    let companyLabel = UILabel(text: "Facebok", font: .boldSystemFont(ofSize: 12))
    
    let titleLable = UILabel(text: "Keeping up with friends is faster than ever", font: .systemFont(ofSize: 24))
    let imageView = UIImageView(cornerRadius: 8)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        companyLabel.textColor = .blue
//        backgroundColor = .green
        titleLable.numberOfLines = 2
        
        let stackView = VerticalStackView(arrangedSubViews: [companyLabel,
                                                             titleLable,
                                                             imageView
                                                            ])
        stackView.spacing = 16
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 16, left: 0, bottom: 0, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
