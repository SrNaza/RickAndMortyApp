//
//  HomeCharacterSearch.swift
//  MortyApp
//
//  Created by Nazareth Villalba on 19/09/23.
//

import Foundation

struct HomeCharacterSearch: Codable {
    let info: Info
    let results: [Character]
}

struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

struct Character: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Location
    let location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
    
    init() {
        self.id = 0
        self.name = ""
        self.status = ""
        self.species = ""
        self.type = ""
        self.gender = ""
        self.origin = Location(name: "", url: "")
        self.location = Location(name: "", url: "")
        self.image = ""
        self.episode = []
        self.url = ""
        self.created = ""
    }
}

struct Location: Codable {
    let name: String
    let url: String
}

