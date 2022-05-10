//
//  AppCoordinator.swift
//  iOSTemplateFromScratch
//
//  Created by Apple on 19/04/22.
//

import Foundation
import RxSwift

class ViewCoordinator: BaseCoordinator {
    private let router: NavigationRouter

    init(router: NavigationRouter) {
        self.router = router
        super.init()
    }

    override func start() -> Observable<Void> {
        let itunesAPIService = ItunesAPIService()
        let viewModel = ViewModel(itunes: itunesAPIService)
        let rootVc = ViewController(viewModel: viewModel)

        // output subscription
        viewModel.output.showDetail
            .flatMap { [weak self] content -> Observable<Void> in
            guard let strongSelf = self else { return .empty() }
            return strongSelf.showSongDetail(content, in: strongSelf.router)
        }
            .subscribe(onNext: { print("Finished Detail") })
            .disposed(by: disposeBag)

        return router.rx.push(rootVc, animated: true)
    }

    private func showSongDetail(_ content: ItuneResult, in router: NavigationRouter) -> Observable<Void> {
        let detailCoordinator = DetailsCoordinator(router: router, content: content)
        return coordinate(to: detailCoordinator)
    }
}
