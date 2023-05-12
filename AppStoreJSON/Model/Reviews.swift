//
//  Reviews.swift
//  AppStoreJSON
//
//  Created by Renat Nazyrov on 10.05.2023.
//

import Foundation

struct Reviews: Decodable {
    let feed: ReviewFeed
}

struct ReviewFeed: Decodable {
    let entry: [Entry]
}

struct Entry: Decodable {
    let author: Author
    let title: Label
    let content: Label
    
    let rating: Label
    
    //чтобы мы могли спарсить json параметр im:rating, на который свифт очевидно ругается, нужно сделать кастомный ключ как ниже. как я понял нужно обязательно указать все те, что мы менять не будем (внутри текущего уровня, в данном случае в скобках Entry) и при этом через "" ниже указать реальный ключ для нашего dummy параметра: 
    private enum CodingKeys: String, CodingKey {
        case author, title, content
        case rating = "im:rating"
    }
}

struct Author: Decodable {
    let name: Label
}

struct Label: Decodable {
    let label: String
}
