//
//  SearchResult.swift
//  AppStoreJSON
//
//  Created by Renat Nazyrov on 28.03.2023.
//

import Foundation

struct SearchResult: Decodable {
    let resultCount: Int
    let results: [Result]
}

struct Result: Decodable {
    let trackName: String
    let primaryGenreName: String
}
