//
//  Endpoint.swift
//  iOSTemplateFromScratch
//
//  Created by Apple on 20/04/22.
//

import Foundation

protocol Endpoint {
    // http or https
    var scheme: String { get }
    // base url: itunes.apple.come
    var baseUrl: String { get }
    // path
    var path: String { get }
    // method: get, post, put etc
    var method: String { get }
    // query params
    var params: [URLQueryItem] { get }
    var port: Int? { get }
}
