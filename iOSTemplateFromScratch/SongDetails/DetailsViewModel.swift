//
//  DetailsViewModel.swift
//  iOSTemplateFromScratch
//
//  Created by Apple on 22/04/22.
//

import Foundation
import RxSwift
import RxCocoa

class DetailsViewModel: ViewModelType {
    let input = Input()
    let output: Output
    
    struct Input {
        let onCancel = PublishRelay<Void>()
    }
    
    struct Output {
        let song: BehaviorSubject<ItuneResult>
        let navigateBack: Observable<Void>
    }
    
    init (content: ItuneResult) {
        let song = BehaviorSubject<ItuneResult>(value: content)
        let onCancel = input.onCancel
        output = Output(song: song, navigateBack: onCancel.asObservable())
    }
}
