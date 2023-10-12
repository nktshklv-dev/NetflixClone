//
//  Movie.swift
//  NetflixClone
//
//  Created by Nikita Shakalov on 10/11/23.
//

import Foundation

struct TrendingMoviesResponse: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let id: Int
    let title: String?
    let original_language: String?
    let original_title: String?
    let overview: String?
    let poster_path: String?
    let release_date: String?
    let vote_average: Double?
    let vote_count: Int?
}
