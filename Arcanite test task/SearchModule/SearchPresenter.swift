//
//  SearchPresenter.swift
//  Arcanite test task
//
//  Created by Илья Сергеевич on 01.06.2023.
//

import Foundation
import UIKit

protocol SearchPresenterProtocol: AnyObject {
    func didEnter(keyword: String)
    func didReceive(songs: [Song])
    func numberOfSongs() -> Int
    func numberOfSections() -> Int
    func songAt(index: Int) -> Song
    func didSelectSong(_ song: Song)
}

class SearchPresenter: SearchPresenterProtocol {
    weak var view: SearchViewProtocol!
    var interactor: SearchInteractorProtocol!
    var router: SearchRouterProtocol!
    
    private var workItem: DispatchWorkItem?

    private var songs: [Song] = []

    func didEnter(keyword: String) {
        guard keyword.count > 3 else {
            // Minimum letters
            view.updateView()
            return
        }

        workItem?.cancel()
        workItem = DispatchWorkItem {
            self.interactor.fetchSongs(for: keyword)
        }
        //Set up delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: workItem!)
    }

    func didReceive(songs: [Song]) {
        self.songs = songs
        view.updateView()
    }
    
    func numberOfSongs() -> Int {
        return songs.count
    }

    func songAt(index: Int) -> Song {
        return songs[index]
    }
    
    func numberOfSections() -> Int {
            return 1
        }
        //Open a detailed view after clicking on the cell
    func didSelectSong(_ song: Song) {
        router.presentPlayer(from: view, for: song)
    }
}

