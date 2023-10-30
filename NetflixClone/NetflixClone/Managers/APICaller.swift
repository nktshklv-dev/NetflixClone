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
    
    func getTrendingMovies(completion: @escaping(Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.APIKey)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {return}
            do{
                let decodedData = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(decodedData.results))
            }
            catch {
                //refactor
                print(error.localizedDescription)
            }
            
        }
        task.resume()
    }
    
    func getTrendingTVShows(completion: @escaping(Result<[Title],Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/tv/day?api_key=\(Constants.APIKey)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _ , error in
            guard let data = data, error == nil else {return}
            do {
                let decodedData = try  JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(decodedData.results))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getUpcomingMovies(completion: @escaping(Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/upcoming?api_key=\(Constants.APIKey)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _ , error in
            guard let data = data, error == nil else {return}
            
            do {
                let decodedData = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                print(decodedData)
                completion(.success(decodedData.results))
            }
            catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getPopular(completion: @escaping(Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/popular?api_key=\(Constants.APIKey)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {return}
            do {
                let decodedData = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                print(decodedData)
                completion(.success(decodedData.results))
            }
            catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getTopRated(completion: @escaping(Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/popular?api_key=\(Constants.APIKey)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _ , error in
            guard let data = data, error == nil else {return}
            
            do {
                let decodedData = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                print(decodedData)
                completion(.success(decodedData.results))
            }
            catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}



