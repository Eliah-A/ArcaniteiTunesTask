//
//  NetworkError.swift
//  Arcanite test task
//
//  Created by Илья Сергеевич on 02.06.2023.
//

import Foundation
// this is new feature line 
//and this is new line from github
enum NetworkError: Error {
    case badURL
    case networkError(Error)
    case decodingError
    case unknownError
    
    var localizedDescription: String {
        switch self {
        case .badURL:
            return "Bad URL"
        case .networkError(let error):
            return error.localizedDescription
        case .decodingError:
            return "Error occurred while decoding data"
        case .unknownError:
            return "Unknown error occurred"
        }
    }
}
