//
//  DetailsViewController.swift
//  iOSTemplateFromScratch
//
//  Created by Apple on 22/04/22.
//

import UIKit
import AVKit
import AVFoundation

class DetailsViewController: BaseViewController {
    let viewModel = DetailsViewModel()
    let playerViewController = AVPlayerViewController()
    
    var videoPlayer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        setUpNavBar(title: "Song Details")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setUp() {
        view.addSubview(videoPlayer)
        NSLayoutConstraint.activate([
            videoPlayer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            videoPlayer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            videoPlayer.topAnchor.constraint(equalTo: view.topAnchor),
            videoPlayer.heightAnchor.constraint(equalToConstant: 300.0)
        ])
        guard let song = viewModel.song else { return }
        guard let previewUrlString = song.previewUrl else { return }
        guard let previewUrl = URL(string: previewUrlString) else { return }
        guard let previewImageURLString = song.artworkUrl100 else { return }
        let avPlayer = AVPlayer(url: previewUrl)
        playerViewController.player = avPlayer
        playerViewController.view.frame = videoPlayer.frame
        videoPlayer.addSubview(playerViewController.view)
        let imageView = CacheImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 300)
        //imageView.center = playerViewController.view.center
        imageView.downloadImageFrom(urlString: previewImageURLString, imageMode: .scaleAspectFill) { [weak self] image in
            guard let self = self, let playerImage = image else { return }
            DispatchQueue.main.async {
                imageView.image = playerImage
                self.playerViewController.contentOverlayView?.addSubview(imageView)
            }
        }
    }
}
