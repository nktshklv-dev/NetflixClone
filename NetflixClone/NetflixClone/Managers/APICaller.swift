//
//  APICaller.swift
//  NetflixClone
//
//  Created by Nikita Shakalov on 10/11/23.
//

import Foundation

struct Constants {
    static let APIKey = "c98312bfa1d1fdae5ebc6c8aac889623"
    static let baseURL = "https://api.themoviedb.org"
    static let test = "https://api.themoviedb.org/3/trending/all/day?api_key=c98312bfa1d1fdae5ebc6c8aac889623"
}
class APICaller {
    static let shared = APICaller()
    
    func getTrendingMovies(completion: @escaping(String) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/all/day?api_key=\(Constants.APIKey)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {return}
            do{
                let resutls = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                print(resutls)
            }
            catch {
                //refactor
                print(error.localizedDescription)
            }
            
        }
        task.resume()
        
    }
}


