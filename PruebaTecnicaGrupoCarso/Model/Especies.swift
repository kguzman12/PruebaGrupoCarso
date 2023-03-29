//
//  Species.swift
//  PruebaTecnicaGrupoCarso
//
//  Created by MacBookMBA9 on 27/03/23.
//

import Foundation

struct Especies: Codable {
    let id: Int
    let name: String
    let names: [Name]
    let pokemon: [Pokmons]

    enum CodingKeys: String, CodingKey {
        case id
        case name, names
        case pokemon
    }
    
    init(id: Int, name: String, names: [Name], pokemon: [Pokmons]) {
        self.id = id
        self.name = name
        self.names = names
        self.pokemon = pokemon
    }
    
    init() {
        self.id = 0
        self.name = ""
        self.names = []
        self.pokemon = []
    }
}

struct Name: Codable {
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name
    }
    
    init(name: String) {
        self.name = name
    }
    
    init(){
        self.name = ""
    }
}

struct Pokmons: Codable {
    let pokemon: Generation
    let slot: Int
    
    enum CodingKeys: String, CodingKey {
        case pokemon
        case slot
    }
    
    init(pokemon: Generation, slot: Int) {
        self.pokemon = pokemon
        self.slot = slot
    }
    
    init() {
        self.pokemon = Generation()
        self.slot = 0
    }
}

struct Generation: Codable {
    let name: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case url
    }
    
    init(name: String, url: String) {
        self.name = name
        self.url = url
    }
    
    init() {
        self.name = ""
        self.url = ""
    }
}


