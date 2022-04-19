//
//  ViewModel.swift
//  iOSTemplateFromScratch
//
//  Created by Apple on 19/04/22.
//

import Foundation

struct SongDataModel {
    let icon: String
    let title: String
    let description: String
}

class ViewModel {
    var songsResult: [SongDataModel] = []
    func initialiseArray() {
        let dummyData1 = SongDataModel(icon: "", title: "title_1", description: "title_1")
        songsResult.append(dummyData1)
        let dummyData2 = SongDataModel(icon: "", title: "title_2", description: "title_2")
        songsResult.append(dummyData2)
    }
}
