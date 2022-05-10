//
//  BaseCoordinator.swift
//  templateMVVM
//
//  Created by Benoit Pasquier on 22/2/19.
//  Copyright © 2019 Benoit Pasquier. All rights reserved.
//

import Foundation
import RxSwift

/// Base abstract coordinator generic over the return type of the `start` method.
class BaseCoordinator {
    private let identifier = UUID()
    private var childCoordinators = [UUID: Any]()

    internal let disposeBag = DisposeBag()

    /// Stores coordinator to the `childCoordinators` dictionary.
    ///
    /// - Parameter coordinator: Child coordinator to store.
    private func addChild(coordinator: BaseCoordinator) {
        childCoordinators[coordinator.identifier] = coordinator
    }

    /// Release coordinator from the `childCoordinators` dictionary.
    ///
    /// - Parameter coordinator: Coordinator to release.
    private func freeChild(coordinator: BaseCoordinator?) {
        guard let coordinator = coordinator else { return }
        childCoordinators.removeValue(forKey: coordinator.identifier)
    }

    /// 1. Stores coordinator in a dictionary of child coordinators.
    /// 2. Calls method `start()` on that coordinator.
    /// 3. On the `onNext:` of returning observable of method `start()` removes coordinator from the dictionary.
    ///
    /// - Parameter coordinator: Coordinator to start.
    /// - Returns: Result of `start()` method.
    func coordinate(to coordinator: BaseCoordinator) -> Observable<Void> {
        addChild(coordinator: coordinator)
        return coordinator.start()
            .do(onNext: { [weak self, weak coordinator] _ in self?.freeChild(coordinator: coordinator) })
    }

    /// Starts job of the coordinator.
    ///
    /// - Returns: Result of coordinator job.
    func start() -> Observable<Void> {
        fatalError("Start method should be implemented.")
    }
}
