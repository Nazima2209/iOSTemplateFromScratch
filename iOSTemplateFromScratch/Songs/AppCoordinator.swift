//
//  AppCoordinator.swift
//  iOSTemplateFromScratch
//
//  Created by Apple on 19/04/22.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    var childCoordinator = [Coordinator]()
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let rootVc = ViewController()
        self.navigationController.pushViewController(rootVc, animated: true)
    }
}

