//
//  Extensions.swift
//  AppStoreJSON
//
//  Created by Renat Nazyrov on 19.04.2023.
//

import UIKit

//moved UILabel extension from AppsGroupCell

extension UILabel {
    convenience init(text: String, font: UIFont, numberOfLines: Int = 1){
        self.init(frame: .zero)
        self.text = text
        self.font = font
        self.numberOfLines = numberOfLines
    }
}

extension UIImageView {
    convenience init(cornerRadius: CGFloat) {
        self.init(image: nil)
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFill
    }
}

extension UIButton {
    convenience init(title: String) {
        self.init(type: .system)
        self.setTitle(title, for: .normal)
    }
}
