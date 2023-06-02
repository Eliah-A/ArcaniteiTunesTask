//
//  SongCell.swift
//  Arcanite test task
//
//  Created by Илья Сергеевич on 01.06.2023.
//

import Foundation
import UIKit

class SongCell: UICollectionViewCell {
    static let identifier = "SongCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = .cellImageViewCornerRadius
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .cellDefaultSpacing),
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: .cellDefaultSpacing),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: .cellTrailingSpacing),
            imageView.widthAnchor.constraint(equalToConstant: .cellImageSize),
            imageView.heightAnchor.constraint(equalToConstant: .cellImageSize),
            
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: .cellTitleLeadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: .cellTrailingSpacing),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: .cellTitleTopSpacing),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: .cellDescriptionLeadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: .cellTrailingSpacing),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: .cellDefaultSpacing),
        ])
        
        backgroundColor = .secondBackground
        layer.cornerRadius = .cellCornerRadius
    }
    
    func configureCell(with song: Song) {
        titleLabel.text = song.title
        descriptionLabel.text = song.artist

        guard let urlString = song.artworkURL, let imageURL = URL(string: urlString) else {
            imageView.image = UIImage(systemName: "music.note.list")
            return
        }

        ImageLoaderService.shared.loadImage(from: imageURL) { [weak self] image in
            DispatchQueue.main.async {
                self?.imageView.image = image
            }
        }
    }
}


