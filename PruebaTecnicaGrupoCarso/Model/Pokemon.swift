//
//  Pokemon.swift
//  PruebaTecnicaGrupoCarso
//
//

import Foundation

struct Pokemones: Codable{
    let count: Int?
    let next, previous: String?
    let results: [Result]
    
    enum CodingKeys: String, CodingKey {
        case count
        case results
        case next, previous
    }
    
    init(count: Int?, next: String?, previous: String?, results: [Result]) {
        self.count = count
        self.next = next
        self.previous = previous
        self.results = results
    }
    
    init() {
        self.count = 0
        self.next = ""
        self.previous = ""
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

