//
//  YoutTubeSearchResponse.swift
//  NetflixClone
//
//  Created by Nikita Shakalov on 12/2/23.
//

import Foundation


struct YouTubeSearchResponse: Codable {
    let items: [VideoElement]
}

struct VideoElement: Codable {
    let id: IDVideoElement
}

struct IDVideoElement: Codable {
    let kind: String
    let videoId: String
}
