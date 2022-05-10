//
//  NetworkManager.swift
//  iOSTemplateFromScratch
//
//  Created by Apple on 20/04/22.
//

import Foundation
import RxSwift
import RxCocoa

enum CustomError: Error, LocalizedError {
    case noDataError
    case parsingError
    case jsonToDataConversionError
    case urlError
    var errorDescription: String? {
        switch self {
        case .noDataError:
            return NSLocalizedString("noDataFoundError", comment: "No data found")
        case .parsingError:
            return NSLocalizedString("parsingDataError", comment: "Unable to parse data")
        case .jsonToDataConversionError:
            return NSLocalizedString("jsonToDataConversionError", comment: "Unable to encode json to data")
        case .urlError:
            return NSLocalizedString("urlError", comment: "Unable to convert to URL")
        }
    }
}

class NetworkManager {
    static func callAPI<T: Codable>(endpoint: Endpoint) -> Observable<T> {
        return Observable<T>.create ({ observer in
            var urlComponents = URLComponents()
            urlComponents.path = endpoint.path
            urlComponents.scheme = endpoint.scheme
            urlComponents.queryItems = endpoint.params
            urlComponents.host = endpoint.baseUrl
            urlComponents.port = endpoint.port
            guard let url = urlComponents.url else {
                return observer.onError(CustomError.urlError) as! Disposable
            }
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = endpoint.method
            let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                guard error == nil else {
                    return
                }
                guard response != nil, let data = data else {
                    observer.onError(CustomError.noDataError)
                    return
                }
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    observer.onNext(result)
                } catch let error {
                    print(error)
                    observer.onError(CustomError.parsingError)
                }
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        })
    }
}
