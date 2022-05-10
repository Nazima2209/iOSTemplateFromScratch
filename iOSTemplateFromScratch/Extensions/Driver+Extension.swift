//
//  Driver+Extension.swift
//  iOSTemplateFromScratch
//
//  Created by Apple on 05/05/22.
//

import Foundation
import RxSwift
import RxCocoa

public class BehaviourDriver<Element>: NSObject {
    var behaviour: BehaviorRelay<Element>
    var driver: Driver<Element> {
        return behaviour.asDriver()
    }
    public init(value: Element) {
        behaviour = BehaviorRelay<Element>(value: value)
    }
    public func value() -> Element {
        return behaviour.value
    }
    public func accept(_ event: Element) {
        behaviour.accept(event)
    }
    public func drive(onNext: ((Element) -> Void)? = nil, onCompleted: (() -> Void)? = nil, onDisposed: (() -> Void)? = nil) -> Disposable {

        return driver.drive(onNext: onNext, onCompleted: onCompleted, onDisposed: onDisposed)
    }

    public func drive<Observer>(_ observer: Observer) -> Disposable where Observer: ObserverType, Element == Observer.E {
        return driver.drive(observer)
    }
}
