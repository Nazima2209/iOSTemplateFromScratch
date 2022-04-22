//
//  AppCoordinator.swift
//  iOSTemplateFromScratch
//
//  Created by Apple on 19/04/22.
//

import Foundation
import UIKit

class ViewCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    var childCoordinator = [Coordinator]()
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let rootVc = ViewController()
        rootVc.viewModel.delegate = self
        self.navigationController.pushViewController(rootVc, animated: true)
    }
}

extension ViewCoordinator: ViewModelDelegate {
    func loadSongDetailsScreen(song: ItuneResult) {
        let detailsCoordinator = DetailsCoordinator(navigationController: navigationController, song: song)
        detailsCoordinator.start()
    }
}

