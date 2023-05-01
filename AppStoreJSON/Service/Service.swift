//
//  Service.swift
//  AppStoreJSON
//
//  Created by Renat Nazyrov on 29.03.2023.
//

import Foundation

class Service {
    static let shared = Service() //singleton
    
    func fetchApps(searchTerm: String, completion: @escaping (SearchResult?, Error?) -> ()) {
        
//        print("Fetching itunes apps from Service Layer")
        
        let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&entity=software"
        fetchGenericJSONData(urlString: urlString, completion: completion)
        
//        // fetch data from internet
//        guard let url = URL(string: urlString) else { return }
//        URLSession.shared.dataTask(with: url) { data, resp, err in
//
//            if let err = err {
//                print("failed to fetch apps:", err)
//                completion([], nil)
//                return
//            }
//            // success
//
//            guard let data = data else { return }
//
//            do {
//                let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
////                print(searchResult)
//                completion(searchResult.results, nil)
//
//            } catch let jsonErr {
//                print("Failed to decode json:", jsonErr)
//                completion([], jsonErr)
//            }
//
//
//        }.resume() // fires off the request
    }
    
    func fetchTopFree(completion: @escaping (AppGroup?, Error?) -> ()) {
        let urlString = "https://rss.applemarketingtools.com/api/v2/us/apps/top-free/50/apps.json"
        fetchAppGroup(urlString: urlString, completion: completion)
    }
    
    func fetchTopPaid(completion: @escaping (AppGroup?, Error?) -> ()) {
        let urlString = "https://rss.applemarketingtools.com/api/v2/us/apps/top-paid/50/apps.json"
        fetchAppGroup(urlString: urlString, completion: completion)
    }
    
    //helper
    func fetchAppGroup(urlString: String, completion: @escaping (AppGroup?, Error?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            
            if let err = err {
                completion(nil, err)
                return
            }
            
            do { let appGroup = try JSONDecoder().decode(AppGroup.self, from: data!)
//                appGroup.feed.results.forEach({print($0.name)})
                completion(appGroup, nil)
            } catch {
                completion(nil, error)
                print("Failed to decode:", error)
            }
            
        }.resume()
    }
    func fetchSocialApps(completion: @escaping ([SocialApp]?, Error?) -> Void) {
        let urlString = "https://api.letsbuildthatapp.com/appstore/social"
//        guard let url = URL(string: urlString) else { return }
//        URLSession.shared.dataTask(with: url) { (data, resp, err) in
//            if let err = err {
//                completion(nil, err)
//                return
//            }
//
//            do { let objects = try JSONDecoder().decode([SocialApp].self, from: data!)
//                completion(objects, nil)
//            } catch {
//                completion(nil, error)
//                print("Failed to decode:", error)
//            }
//
//        }.resume()
        
        // now all of it is in just one string:
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    // declare my generic json function here
    func fetchGenericJSONData<T: Decodable>(urlString: String, completion: @escaping (T?, Error?) -> ()) {
        
        print ("T is type:", T.self)
        
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                completion(nil, err)
                return
            }
            
            do {
                let objects = try JSONDecoder().decode(T.self, from: data!)
                completion(objects, nil)
            } catch {
                completion(nil, error)
                print("Failed to decode:", error)
            }
            
        }.resume()
    }
}
