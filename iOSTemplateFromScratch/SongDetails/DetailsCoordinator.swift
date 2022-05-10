//
//  DetailsCoordinator.swift
//  iOSTemplateFromScratch
//
//  Created by Apple on 22/04/22.
//

import Foundation
import UIKit
import RxSwift

class DetailsCoordinator: BaseCoordinator {
    private let router: NavigationRouter
    private let content: ItuneResult

    init(router: NavigationRouter, content: ItuneResult) {
        self.router = router
        self.content = content
        super.init()
    }

    override func start() -> Observable<Void> {
        let viewModel = DetailsViewModel(content: content)
        let viewController = DetailsViewController(viewModel: viewModel)
        viewController.edgesForExtendedLayout = []
        viewModel.output.navigateBack
            .subscribe(onNext: { [weak self] in self?.router.pop(animated: true) })
            .disposed(by: disposeBag)

        return router.rx.push(viewController, animated: true)
    }

    deinit {
        print("FeatureDetailCoordinator deinit")
    }
}
