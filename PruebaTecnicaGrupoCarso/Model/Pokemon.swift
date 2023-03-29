//
//  Pokemon.swift
//  PruebaTecnicaGrupoCarso
//
//

import Foundation

struct Pokemones: Codable{
    let count: Int?
    let results: [Result]
    
    enum CodingKeys: String, CodingKey {
        case count
        case results
    }
    
    init(count: Int?, results: [Result]) {
        self.count = count
        self.results = results
    }
    
    init() {
        self.count = 0
        self.results = []
    }
}

struct Result: Codable {
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
    
    init(){
        self.name = ""
        self.url = ""
    }
}

