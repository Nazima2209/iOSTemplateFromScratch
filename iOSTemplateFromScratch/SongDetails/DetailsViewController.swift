//
//  DetailsViewController.swift
//  iOSTemplateFromScratch
//
//  Created by Apple on 22/04/22.
//

import UIKit
import AVKit
import AVFoundation
import RxSwift

class DetailsViewController: BaseViewController {
    var viewModel: DetailsViewModel
    let playerViewController = AVPlayerViewController()
    let disposeBag = DisposeBag()

    var videoPlayer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    init (viewModel: DetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        setUpNavBar(title: "Song Details")
        self.bindTo()
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
    }

    private func bindTo() {
        viewModel.output.song.subscribe(onNext: { [weak self] song in
            guard let self = self else { return }
            guard let previewUrlString = song.previewUrl else { return }
            guard let previewUrl = URL(string: previewUrlString) else { return }
            guard let previewImageURLString = song.artworkUrl100 else { return }
            let avPlayer = AVPlayer(url: previewUrl)
            self.playerViewController.player = avPlayer
            self.playerViewController.view.frame = self.videoPlayer.frame
            self.videoPlayer.addSubview(self.playerViewController.view)
            let imageView = CacheImageView()
            imageView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 300)
            //imageView.center = playerViewController.view.center
            imageView.downloadImageFrom(urlString: previewImageURLString, imageMode: .scaleAspectFill) { [weak self] image in
                guard let self = self, let playerImage = image else { return }
                DispatchQueue.main.async {
                    imageView.image = playerImage
                    self.playerViewController.contentOverlayView?.addSubview(imageView)
                }
            }
        }).disposed(by: disposeBag)
    }
}
