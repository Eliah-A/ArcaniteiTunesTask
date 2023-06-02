//
//  Entity.swift
//  Arcanite test task
//
//  Created by Илья Сергеевич on 01.06.2023.
//

import Foundation

struct ApiResponse: Decodable {
    let resultCount: Int
    let results: [Song]
}

struct Song: Decodable {
    let title: String?
    let artist: String?
    let artworkURL: String?
    let previewUrl: String?

    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case artist = "artistName"
        case artworkURL = "artworkUrl100"
        case previewUrl
    }
}
