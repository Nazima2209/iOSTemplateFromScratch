//
//  Presentable.swift
//  templateMVVM
//
//  Created by Benoit Pasquier on 21/3/19.
//  Copyright © 2019 Benoit Pasquier. All rights reserved.
//

import UIKit

public protocol Presentable {
    func viewControllerPresenting() -> UIViewController?
}

extension UIViewController : Presentable {
    public func viewControllerPresenting() -> UIViewController? {
        return self
    }
}
