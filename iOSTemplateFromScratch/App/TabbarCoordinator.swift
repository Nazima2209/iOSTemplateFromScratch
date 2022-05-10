//
//  TabBarCoordinator.swift
//  templateMVVM
//
//  Created by Benoit Pasquier on 22/2/19.
//  Copyright © 2019 Benoit Pasquier. All rights reserved.
//

import RxSwift
import UIKit

class TabBarCoordinator: BaseCoordinator {
    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    override func start() -> Observable<Void> {
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = []
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()

        // TODO
//        let firstTabCoordinator = FeatureListCoordinator(tabBarController: tabBarController)
//        let secondTabCoordinator = FeatureListCoordinator(tabBarController: tabBarController)
//
//        let completed = coordinate(to: firstTabCoordinator)
//            .withLatestFrom(coordinate(to: secondTabCoordinator))

        return .never()
    }

    private func showTabbarController(_ viewControllers: [UIViewController]) {
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = viewControllers
    }
}
