//
//  AppGroup.swift
//  AppStoreJSON
//
//  Created by Renat Nazyrov on 23.04.2023.
//

import Foundation

struct AppGroup: Decodable {
    let feed: Feed
}

struct Feed: Decodable {
    let title: String
    let results: [FeedResult]
}

struct FeedResult: Decodable {
    let id, artistName, name, artworkUrl100: String
//    let artistName: String
//    let name: String
//    let artworkUrl100: String
    let url: String
}
