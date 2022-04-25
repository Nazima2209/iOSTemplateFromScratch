//
//  ViewModel.swift
//  iOSTemplateFromScratch
//
//  Created by Apple on 19/04/22.
//

import Foundation

protocol ItunesAPIServiceProtocol {
    func searchSong(searchText: String, completion: @escaping(_ result: Result<Any?, Error>) -> Void)
}

struct ItunesAPIService: ItunesAPIServiceProtocol {
    func searchSong(searchText: String, completion: @escaping (Result<Any?, Error>) -> Void) {
        let endpoint = ItunesEndpoint(searchText: searchText)
        NetworkManager.callAPI(endpoint: endpoint) { result in
            completion(result)
        }
    }
}

protocol ViewModelDelegate: AnyObject {
    func loadSongDetailsScreen(song: ItuneResult)
}

class ViewModel {
    let itunesService: ItunesAPIService
    var songsResult: [ItuneResult] = []
    weak var delegate: ViewModelDelegate?

    init(itunes: ItunesAPIService) {
        itunesService = itunes
    }

    func callItunesSearchApi(searchText: String, completion: @escaping(Bool) -> Void) {
        itunesService.searchSong(searchText: searchText) { result in
            switch result {
            case .success(let itunesSearchResult):
                if let result = itunesSearchResult as? ItunesSearchResult {
                    let itunesResult = result.results
                    if itunesResult.isEmpty {
                        self.songsResult = []
                    } else {
                        self.songsResult = itunesResult
                    }
                    completion(true)
                }
            case .failure(_):
                self.songsResult = []
                completion(false)
            }
        }
    }
}
