//
//  DetailsCoordinator.swift
//  iOSTemplateFromScratch
//
//  Created by Apple on 22/04/22.
//

import Foundation
import UIKit

class DetailsCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinator: [Coordinator] = []
    let song: ItuneResult
    
    init(navigationController: UINavigationController, song: ItuneResult) {
        self.navigationController = navigationController
        self.song = song
    }
    
    func start() {
        let vc = DetailsViewController()
        vc.viewModel.song = song
        vc.edgesForExtendedLayout = []
        navigationController.pushViewController(vc, animated: true)
    }
}
