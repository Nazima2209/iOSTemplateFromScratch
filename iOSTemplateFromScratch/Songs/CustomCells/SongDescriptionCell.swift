//
//  SongDescriptionCell.swift
//  iOSTemplateFromScratch
//
//  Created by Apple on 19/04/22.
//

import Foundation
import UIKit

class SongDescriptionCell: UITableViewCell {
    let songIcon: CacheImageView = {
        let imageView = CacheImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 4.0
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let songTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let songDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = .systemFont(ofSize: 10)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        addSubview(songIcon)
        addSubview(songTitleLabel)
        addSubview(songDescriptionLabel)
        NSLayoutConstraint.activate([
            // Icon Constraints
            songIcon.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5.0),
            songIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            songIcon.widthAnchor.constraint(equalToConstant: 30.0),
            songIcon.heightAnchor.constraint(equalToConstant: 30.0),
            // Title Label Constraints
            songTitleLabel.leadingAnchor.constraint(equalTo: songIcon.trailingAnchor, constant: 10.0),
            songTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5.0),
            songTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            // Description Label Constraints
            songDescriptionLabel.topAnchor.constraint(equalTo: songTitleLabel.bottomAnchor, constant: 5.0),
            songDescriptionLabel.leadingAnchor.constraint(equalTo: songTitleLabel.leadingAnchor),
            songDescriptionLabel.trailingAnchor.constraint(equalTo: songDescriptionLabel.trailingAnchor),
            //songDescriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 5.0)
        ])
    }
    
    func setDataInCell(data: ItuneResult) {
        songTitleLabel.text = data.trackName
        songDescriptionLabel.text = data.artistName
        if let imageUrl = data.artworkUrl30 {
            songIcon.downloadImageFrom(urlString: imageUrl, imageMode: .scaleAspectFill)
        }
    }
}
