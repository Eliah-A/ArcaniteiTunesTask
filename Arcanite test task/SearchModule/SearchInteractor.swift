//
//  SearchInteractor.swift
//  Arcanite test task
//
//  Created by Илья Сергеевич on 01.06.2023.
//

import Foundation
import UIKit

protocol SearchInteractorProtocol: AnyObject {
    func fetchSongs(for keyword: String)
}

class SearchInteractor: SearchInteractorProtocol {
    weak var presenter: SearchPresenterProtocol!
    var networkService: NetworkService = NetworkService()

    func fetchSongs(for keyword: String) {

        guard let url = API.iTunesSearch(keyword: keyword).urlString else {
            print(NetworkError.badURL.localizedDescription)
            return
        }

        networkService.fetchData(from: url) { (data, error) in
            if let error = error {
                print("Network Error: \(error.localizedDescription)")
                return
            }
            
            if let data = data {
                do {
                    let apiResponse = try JSONDecoder().decode(ApiResponse.self, from: data)
                    self.presenter.didReceive(songs: apiResponse.results)
                } catch {
                    print("Decoding Error: \(NetworkError.decodingError.localizedDescription)")
                }
            }
        }
    }
}



