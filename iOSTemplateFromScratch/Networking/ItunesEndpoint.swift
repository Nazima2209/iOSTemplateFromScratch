//
//  ItunesEndpoint.swift
//  iOSTemplateFromScratch
//
//  Created by Apple on 20/04/22.
//

import Foundation

struct ItunesEndpoint: Endpoint, Equatable {
    var searchText: String
    var testFailure: Bool = false
    var scheme: String {
        return "https"
    }
    
    var baseUrl: String {
        return "itunes.apple.com"
    }
    
    var path: String {
        return testFailure ? "/fail" : "/search"
    }
    
    var method: String {
        return "get"
    }
    
    var params: [URLQueryItem] {
        return [
            URLQueryItem(name: "term", value: searchText),
            URLQueryItem(name: "media", value: "music")
        ]
    }
    
    var port: Int? {
        return nil
    }
}
