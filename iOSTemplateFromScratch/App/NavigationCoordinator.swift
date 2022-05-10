//
//  NavigationCoordinator.swift
//  templateMVVM
//
//  Created by Benoit Pasquier on 21/3/19.
//  Copyright © 2019 Benoit Pasquier. All rights reserved.
//

import RxSwift
import UIKit

class NavigationCoordinator : BaseCoordinator {
    private let window: UIWindow
    private let router: NavigationRouter
    
    init(window: UIWindow) {
        self.window = window
        self.router = NavigationRouter(rootViewController: UINavigationController())
    }
    
    override func start() -> Observable<Void> {
        window.rootViewController = router.rootViewController
        window.makeKeyAndVisible()
        
        let songlist = ViewCoordinator(router: router)
        
        return coordinate(to: songlist)
    }
}
