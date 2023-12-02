//
//  APICaller.swift
//  NetflixClone
//
//  Created by Nikita Shakalov on 10/11/23.
//

import Foundation

struct Constants {
    static let baseURL = "https://api.themoviedb.org"
    static let YouTube_baseURL = "https://youtube.googleapis.com/youtube/v3/search?"
    static let test = "https://api.themoviedb.org/3/trending/all/day?api_key=c98312bfa1d1fdae5ebc6c8aac889623"
}

enum APIError: Error {
    case failedToGetData
}
class APICaller {
    static let shared = APICaller()
    
    func getTrendingMovies(completion: @escaping(Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(SensitiveData.APIKey)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {return}
            do{
                let decodedData = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(decodedData.results))
            }
            catch {
                completion(.failure(APIError.failedToGetData))
            }
            
        }
        task.resume()
    }
    
    func getTrendingTVShows(completion: @escaping(Result<[Title],Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/tv/day?api_key=\(SensitiveData.APIKey)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _ , error in
            guard let data = data, error == nil else {return}
            do {
                let decodedData = try  JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(decodedData.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getUpcomingMovies(completion: @escaping(Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/upcoming?api_key=\(SensitiveData.APIKey)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _ , error in
            guard let data = data, error == nil else {return}
            
            do {
                let decodedData = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(decodedData.results))
            }
            catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getPopular(completion: @escaping(Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=c98312bfa1d1fdae5ebc6c8aac889623&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {return}
            do {
                let decodedData = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(decodedData.results))
            }
            catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getTopRated(completion: @escaping(Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/popular?api_key=\(SensitiveData.APIKey)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _ , error in
            guard let data = data, error == nil else {return}
            
            do {
                let decodedData = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(decodedData.results))
            }
            catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getDiscoverMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/discover/movie?api_key=\(SensitiveData.APIKey)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else {return}
        print("test")
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                print("error")
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(decodedData.results))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func search(with query: String, completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return }
        guard let url = URL(string: "\(Constants.baseURL)/3/search/movie?api_key=\(SensitiveData.APIKey)&query=\(query)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {data, _,error in
            
            guard let data = data, error == nil else {return}
            
            do {
                let decodedData = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(decodedData.results))
            } catch {
                completion(.failure(error))
            }
            
        }
        task.resume()
    }
    
    func getMovie(with query: String, completion: @escaping (Result<VideoElement, Error>) -> ()) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(Constants.YouTube_baseURL)q=\(query)&key=\(SensitiveData.YouTube_APIKey)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(YouTubeSearchResponse.self, from: data)
                guard let videoElement = results.items.first else {return}
                completion(.success(videoElement))
                
            } catch {
                completion(.failure(error))
                print(error.localizedDescription)
            }
        }
        
        task.resume()
        
    }
}



