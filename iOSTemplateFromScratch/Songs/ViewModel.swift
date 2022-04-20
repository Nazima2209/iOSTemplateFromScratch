//
//  ViewModel.swift
//  iOSTemplateFromScratch
//
//  Created by Apple on 19/04/22.
//

import Foundation

class ViewModel {
    var songsResult: [ItuneResult] = []
    
    func callItunesSearchApi(searchText: String, completion: @escaping(Bool)->Void) {
        let endpoint = ItunesEndpoint(searchText: searchText)
        NetworkManager.callAPI(endpoint: endpoint) { result in
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
