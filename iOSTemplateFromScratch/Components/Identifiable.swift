//
//  Identifiable.swift
//  templateMVVM
//
//  Created by Benoit Pasquier on 22/2/19.
//  Copyright © 2019 Benoit Pasquier. All rights reserved.
//

import UIKit

protocol Identifiable {
    static var identifier: String { get }
}

extension Identifiable where Self: UIViewController {
    static var identifier: String {
        return String(describing: Self.self)
    }
}
