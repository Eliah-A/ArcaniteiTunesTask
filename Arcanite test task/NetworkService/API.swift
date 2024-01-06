//
//  API.swift
//  Arcanite test task
//
//  Created by Илья Сергеевич on 02.06.2023.
//

import Foundation

enum API {
    case iTunesSearch(keyword: String)
//some new stuff to conflict 
    var urlString: URL? {
        switch self {
        case .iTunesSearch(let keyword):
            return URL(string: "https://itunes.apple.com/search?term=\(keyword)")
        }
    }
}
