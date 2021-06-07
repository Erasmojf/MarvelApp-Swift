//
//  Comic.swift
//  MarvelApp Swift (iOS)
//
//  Created by Erasmo J.F Da Silva on 21/05/21.
//

import SwiftUI

struct APIComicResult: Codable{
    var data: APIComicData
}

struct APIComicData: Codable {
    var count: Int
    var results: [Comic]
}

struct Character: Identifiable, Codable {
    var id: Int
    var title: String
    var description:String
    var thumbnail: [String:String]
    var urls:[[String: String]]
}
