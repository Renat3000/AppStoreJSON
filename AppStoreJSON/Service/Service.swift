//
//  Service.swift
//  AppStoreJSON
//
//  Created by Renat Nazyrov on 29.03.2023.
//

import Foundation

class Service {
    static let shared = Service() //singleton
    
    func fetchApps(searchTerm: String, completion: @escaping ([Result], Error?) -> ()) {
        
//        print("Fetching itunes apps from Service Layer")
        
        let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&entity=software"
            // fetch data from internet
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, resp, err in
            
            if let err = err {
                print("failed to fetch apps:", err)
                completion([], nil)
                return
            }
            // success
//            print(String(data: data!, encoding: .utf8))
            
            guard let data = data else { return }
            
            do {
                let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
//                print(searchResult)
                completion(searchResult.results, nil)
                
            } catch let jsonErr {
                print("Failed to decode json:", jsonErr)
                completion([], jsonErr)
            }
            
            
        }.resume() // fires off the request
    }
}
