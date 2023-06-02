//
//  NetworkService.swift
//  Arcanite test task
//
//  Created by Илья Сергеевич on 02.06.2023.
//

import Foundation

class NetworkService {
    func fetchData(from url: URL, completion: @escaping (Data?, NetworkError?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(nil, .networkError(error))
                } else if let data = data {
                    completion(data, nil)
                } else {
                    completion(nil, .unknownError)
                }
            }
        }
        task.resume()
    }
}
