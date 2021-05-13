//
//  Character.swift
//  MarvelApp Swift (iOS)
//
//  Created by Erasmo J.F Da Silva on 13/05/21.
//

import SwiftUI
struct APIResult: Codable{
    var data: APICharacterData
}

struct APICharacterData: Codable {
    var count: Int
    var results: [Character]
}

struct Character: Identifiable, Codable {
    var id: Int
    var name: String
    var description:String
    var thumbnail: [String:String]
    var urls:[[String: String]]
}
