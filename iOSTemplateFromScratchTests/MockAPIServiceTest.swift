//
//  MockAPIServiceTest.swift
//  iOSTemplateFromScratchTests
//
//  Created by Apple on 26/04/22.
//

import XCTest
@testable import iOSTemplateFromScratch

enum ErrorTypes: Error {
    case parsingError
    case jsonToDataConversionError
}

class MockAPIServiceTest: ItunesAPIServiceProtocol {

    var shouldReturnSuccess: Bool
    let jsonString = """
        {
        "resultCount":1,
        "results": [
        {"wrapperType":"track", "kind":"song", "artistId":909253, "collectionId":1469577723, "trackId":1469577741, "artistName":"Jack Johnson", "collectionName":"Jack Johnson and Friends: Sing-A-Longs and Lullabies for the Film Curious George", "trackName":"Upside Down", "collectionCensoredName":"Jack Johnson and Friends: Sing-A-Longs and Lullabies for the Film Curious George", "trackCensoredName":"Upside Down", "artistViewUrl":"https://music.apple.com/us/artist/jack-johnson/909253?uo=4", "collectionViewUrl":"https://music.apple.com/us/album/upside-down/1469577723?i=1469577741&uo=4", "trackViewUrl":"https://music.apple.com/us/album/upside-down/1469577723?i=1469577741&uo=4",
        "previewUrl":"https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/5e/5b/3d/5e5b3df4-deb5-da78-5d64-fe51d8404d5c/mzaf_13341178261601361485.plus.aac.p.m4a", "artworkUrl30":"https://is1-ssl.mzstatic.com/image/thumb/Music115/v4/ae/4c/d4/ae4cd42a-80a9-d950-16f5-36f01a9e1881/source/30x30bb.jpg", "artworkUrl60":"https://is1-ssl.mzstatic.com/image/thumb/Music115/v4/ae/4c/d4/ae4cd42a-80a9-d950-16f5-36f01a9e1881/source/60x60bb.jpg", "artworkUrl100":"https://is1-ssl.mzstatic.com/image/thumb/Music115/v4/ae/4c/d4/ae4cd42a-80a9-d950-16f5-36f01a9e1881/source/100x100bb.jpg", "collectionPrice":9.99, "trackPrice":1.29, "releaseDate":"2005-01-01T12:00:00Z", "collectionExplicitness":"notExplicit", "trackExplicitness":"notExplicit", "discCount":1, "discNumber":1, "trackCount":14, "trackNumber":1, "trackTimeMillis":208643, "country":"USA", "currency":"USD", "primaryGenreName":"Rock", "isStreamable":true}]
        }
    """

    let failureJsonString = """
        {"resultCount":25,"results": [{"wrapperType":"track"}]
    """

    init(shouldReturnSuccess: Bool = true) {
        self.shouldReturnSuccess = shouldReturnSuccess
    }

    func searchSong(searchText: String, completion: @escaping (Result<Any?, Error>) -> Void) {
        var testString = failureJsonString
        if shouldReturnSuccess {
            testString = jsonString
        }
        do {
            guard let data = testString.data(using: .utf8) else {
                completion(.failure(CustomError.jsonToDataConversionError))
                return
            }
            let songsResult = try JSONDecoder().decode(ItunesSearchResult.self, from: data)
            completion(.success(songsResult))
        } catch {
            print("shouldn't happen")
            completion(.failure(CustomError.parsingError))
        }
    }
}
