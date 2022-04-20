//
//  Coordinator.swift
//  iOSTemplateFromScratch
//
//  Created by Apple on 19/04/22.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    var childCoordinator: [Coordinator] { get set }
    func start()
}
