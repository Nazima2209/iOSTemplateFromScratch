//
//  NavigationRouter+Rx.swift
//  templateMVVM
//
//  Created by Benoit Pasquier on 21/3/19.
//  Copyright © 2019 Benoit Pasquier. All rights reserved.
//

import Foundation
import RxSwift

extension Reactive where Base: NavigationRouter {
    func push(_ presentable: Presentable?, animated: Bool) -> Observable<Void> {
        return Observable.create({ [weak base] observer -> Disposable in
            guard let base = base else {
                observer.onCompleted()
                return Disposables.create()
            }
            
            base.push(presentable, animated: animated, onDisappear: {
                observer.onNext(())
                observer.onCompleted()
            })
            return Disposables.create()
        })
    }
}
