//
//  AppCoordinator.swift
//  templateMVVM
//
//  Created by Benoit Pasquier on 22/2/19.
//  Copyright © 2019 Benoit Pasquier. All rights reserved.
//

import RxSwift
import UIKit

class AppCoordinator: BaseCoordinator {
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }

    override func start() -> Observable<Void> {
//        let tabCoordinator = TabBarCoordinator(window: window)
        let navigationCoordinator = NavigationCoordinator(window: window)
        return coordinate(to: navigationCoordinator)
    }
}
