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

enum APIError: Error {
    case failedToGetData
}
class APICaller {
    static let shared = APICaller()
    
    func getTrendingMovies(completion: @escaping(Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.APIKey)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {return}
            do{
                let decodedData = try JSONDecoder().decode(TrendingMoviesResponse.self, from: data)
                completion(.success(decodedData.results))
            }
            catch {
                //refactor
                print(error.localizedDescription)
            }
            
        }
        task.resume()
    }
    
    func getTrendingTVShows(completion: @escaping(Result<[TV],Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/tv/day?api_key=\(Constants.APIKey)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _ , error in
            guard let data = data, error == nil else {return}
            do {
                let decodedData = try  JSONDecoder().decode(TrendingTVShowsResponse.self, from: data)
                completion(.success(decodedData.results))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}


