//
//  NetworkManager.swift
//  iOSTemplateFromScratch
//
//  Created by Apple on 20/04/22.
//

import Foundation

class NetworkManager {
    static func callAPI(endpoint: Endpoint, completion: @escaping(_ result: Result<Any?, Error>) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.path = endpoint.path
        urlComponents.scheme = endpoint.scheme
        urlComponents.queryItems = endpoint.params
        urlComponents.host = endpoint.baseUrl
        urlComponents.port = endpoint.port
        guard let url = urlComponents.url else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            guard response != nil, let data = data else {
                completion(.failure(error!))
                return
            }
            do {
                let result = try JSONDecoder().decode(ItunesSearchResult.self, from: data)
                completion(.success(result))
            } catch let error {
                print(error)
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
