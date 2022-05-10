//
//  ViewModel.swift
//  iOSTemplateFromScratch
//
//  Created by Apple on 19/04/22.
//

import Foundation
import RxSwift
import RxCocoa

protocol ItunesAPIServiceProtocol {
    func searchSong(searchText: String) -> Observable<ItunesSearchResult>
}

struct ItunesAPIService: ItunesAPIServiceProtocol {
    func searchSong(searchText: String) -> Observable<ItunesSearchResult> {
        let endpoint = ItunesEndpoint(searchText: searchText)
        let result: Observable<ItunesSearchResult> = NetworkManager.callAPI(endpoint: endpoint)
        return result
    }
}

protocol ViewModelDelegate: AnyObject {
    func loadSongDetailsScreen(song: ItuneResult)
}

class ViewModel: ViewModelType {
    var input = Input()
    var output: Output
    var itunesService: ItunesAPIServiceProtocol
    private let disposeBag = DisposeBag()

    struct Input {
        let searchSubject = PublishSubject<String>()
        var searchObserver: AnyObserver<String> {
            return searchSubject.asObserver()
        }
        let selectContent = PublishRelay<ItuneResult>()
    }

    struct Output {
        let contentSubject = BehaviorRelay<[ItuneResult]>(value: [])
        var content: Driver<[ItuneResult]> {
            return contentSubject.asDriver(onErrorJustReturn: [])
        }
        let errorSubject = PublishSubject<String?>()
        var error: Driver<String?> {
            return errorSubject.asDriver(onErrorJustReturn: "Error")
        }
        let showDetail: Observable<ItuneResult>
    }

    init(itunes: ItunesAPIServiceProtocol) {
        self.itunesService = itunes
        self.output = Output(showDetail: input.selectContent.asObservable())
        input.searchSubject
            .asObservable()
            .filter { !$0.isEmpty }
            .distinctUntilChanged()
            .debounce(0.2, scheduler: MainScheduler.instance)
            .flatMapLatest { [weak self] text -> Observable<ItunesSearchResult> in
            return (self?.itunesService.searchSong(searchText: text)
                    .catchError({ [weak self] error -> Observable<ItunesSearchResult> in
                    self?.output.errorSubject.onNext("Error")
                    self?.output.contentSubject.accept([])
                    return Observable.empty()
                }))!
        }
            .map {
            $0.results
        }
            .subscribe(onNext: { element in
            if element.isEmpty {
                self.output.errorSubject.onNext("Result not found")
                self.output.contentSubject.accept([])
            } else {
                self.output.contentSubject.accept(element)
            }
        }, onError: { _ in
                self.output.contentSubject.accept([])
            })
            .disposed(by: disposeBag)

        input.searchSubject
            .asObservable()
            .filter { $0.isEmpty }
            .subscribe(onNext: { element in
                self.output.contentSubject.accept([])
            })
            .disposed(by: disposeBag)
    }
}
