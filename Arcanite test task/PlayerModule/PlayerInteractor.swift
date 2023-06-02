//
//  PlayerInteractor.swift
//  Arcanite test task
//
//  Created by Илья Сергеевич on 02.06.2023.
//

import Foundation
import AVFoundation
var player = AVPlayer()

protocol PlayerInteractorProtocol: AnyObject {
    func playPauseSong(_ song: Song)
}

class PlayerInteractor: PlayerInteractorProtocol {
    
    func playPauseSong(_ song: Song) {
        guard let audioURLString = song.previewUrl, let audioURL = URL(string: audioURLString) else {
            return
        }
        
        let playerItem = AVPlayerItem(url: audioURL)
            //Check player status
            if player.rate == 0 {
                player.replaceCurrentItem(with: playerItem)
                player.play()
            } else {
                player.pause()
            }
    }
}
