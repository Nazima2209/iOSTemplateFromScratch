//
//  CoordinatorRouter.swift
//  templateMVVM
//
//  Created by Benoit Pasquier on 20/3/19.
//  Copyright © 2019 Benoit Pasquier. All rights reserved.
//

import UIKit

public protocol RouterType: class { }

final class NavigationRouter : NSObject, RouterType {
    
    public private(set) var rootViewController: UINavigationController
    private var disappearBlocks: [UIViewController : () -> Void] = [:]
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
        super.init()
    }
    
    func push(_ presentable: Presentable?, animated: Bool, onDisappear: (() -> Void)? = nil) {
        
        guard let viewController = presentable?.viewControllerPresenting() else {
            return
        }
        
        if let onDisappear = onDisappear {
            disappearBlocks[viewController] = onDisappear
        }
        rootViewController.delegate = self
        rootViewController.pushViewController(viewController, animated: animated)
    }
    
    func didDisappear(_ viewController: UIViewController) {
        disappearBlocks[viewController]?()
        disappearBlocks.removeValue(forKey: viewController)
    }
    
    func pop(animated: Bool = true) {
        if let viewController = rootViewController.popViewController(animated: animated) {
            didDisappear(viewController)
        }
    }
}

extension NavigationRouter : UINavigationControllerDelegate {
    
    public func navigationController(_ navigationController: UINavigationController, didShow _: UIViewController, animated _: Bool) {
        // Ensure the view controller is popping
        guard let poppedViewController = navigationController.transitionCoordinator?.viewController(forKey: .from),
            !navigationController.viewControllers.contains(poppedViewController) else {
                return
        }
        
        didDisappear(poppedViewController)
    }
}
