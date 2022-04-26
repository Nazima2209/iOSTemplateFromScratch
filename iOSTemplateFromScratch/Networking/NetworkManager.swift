//
//  NetworkManager.swift
//  iOSTemplateFromScratch
//
//  Created by Apple on 20/04/22.
//

import Foundation

enum CustomError: Error, LocalizedError {
    case noDataError
    case parsingError
    case jsonToDataConversionError
    var errorDescription: String? {
        switch self {
        case .noDataError:
            return NSLocalizedString("noDataFoundError", comment: "No data found")
        case .parsingError:
            return NSLocalizedString("parsingDataError", comment: "Unable to parse data")
        case .jsonToDataConversionError:
            return NSLocalizedString("jsonToDataConversionError", comment: "Unable to encode json to data")
        }
    }
}

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
                completion(.failure(CustomError.noDataError))
                return
            }
            do {
                let result = try JSONDecoder().decode(ItunesSearchResult.self, from: data)
                completion(.success(result))
            } catch let error {
                print(error)
                completion(.failure(CustomError.parsingError))
            }
        }
        task.resume()
    }
}
