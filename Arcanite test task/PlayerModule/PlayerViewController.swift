//
//  PlayerViewController.swift
//  Arcanite test task
//
//  Created by Илья Сергеевич on 02.06.2023.
//

import Foundation
import UIKit

protocol PlayerViewProtocol: AnyObject {
    func updatePlayerInfo(with song: Song)
}

class PlayerViewController: UIViewController, PlayerViewProtocol {
    var presenter: PlayerPresenterProtocol!
    
    private let songImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()

    private let playButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let playImage = UIImage(systemName: "play.fill")
        let stopImage = UIImage(systemName: "pause.fill")
        button.setImage(playImage, for: .normal)
        button.setImage(stopImage, for: .selected)
        button.layer.cornerRadius = 40
        button.backgroundColor =  .secondBackground
        button.tintColor = .mainBackground
        return button
    }()
    
    private let artistLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()

    private let songLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()

    private let timelineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.viewDidLoad()
        playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
    }

    func updatePlayerInfo(with song: Song) {
        guard let urlString = song.artworkURL, let imageURL = URL(string: urlString) else {
            songImageView.image = UIImage(systemName: "music.note.list")
            return
        }
        
        ImageLoaderService.shared.loadImage(from: imageURL) { [weak self] image in
            DispatchQueue.main.async {
                self?.songImageView.image = image
            }
        }
        
        artistLabel.text = song.artist
        songLabel.text = song.title
    }

    @objc private func playButtonTapped() {
        playButton.isSelected = !playButton.isSelected
        presenter.didTapPlayButton()
    }

    private func setupUI() {
        view.backgroundColor = .searchBackground
        
        view.addSubview(songImageView)
        view.addSubview(playButton)
        view.addSubview(artistLabel)
        view.addSubview(songLabel)
        view.addSubview(timelineView)
        
        NSLayoutConstraint.activate([
            songImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: .songImageTopOffset),
            songImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .indent),
            songImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.indent),
            songImageView.heightAnchor.constraint(equalToConstant: .songImageViewHeight),
            
            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playButton.topAnchor.constraint(equalTo: view.topAnchor, constant: .buttonTopOffset),
            playButton.widthAnchor.constraint(equalToConstant: .playButtonWidth),
            playButton.heightAnchor.constraint(equalToConstant: .playButtonWidth),

            artistLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .bigIndent),
            artistLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.bigIndent),
            artistLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: .artistLabelTopOffset),
            
            songLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .bigIndent),
            songLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.bigIndent),
            songLabel.topAnchor.constraint(equalTo: artistLabel.bottomAnchor, constant:.songLabelTopAnchor),
            
            timelineView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .indent),
            timelineView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.indent),
            timelineView.topAnchor.constraint(equalTo: view.topAnchor, constant: .timelineViewTopOffset),
            timelineView.heightAnchor.constraint(equalToConstant: .timelineViewHeightAnchor)
        ])
    }
}
