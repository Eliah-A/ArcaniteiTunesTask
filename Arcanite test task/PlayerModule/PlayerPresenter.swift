//
//  PlayerPresenterProtocol.swift
//  Arcanite test task
//
//  Created by Илья Сергеевич on 02.06.2023.
//

import Foundation

protocol PlayerPresenterProtocol: AnyObject {
    var song: Song { get }
    func viewDidLoad()
    func didTapPlayButton()
}

class PlayerPresenter: PlayerPresenterProtocol {
    weak var view: PlayerViewProtocol!
    var interactor: PlayerInteractorProtocol!
    var router: PlayerRouterProtocol!
    
    var song: Song
    
    init(song: Song) {
        self.song = song
    }

    func viewDidLoad() {
        view.updatePlayerInfo(with: song)
    }
    
    func didTapPlayButton() {
        interactor.playPauseSong(song)
    }
}
