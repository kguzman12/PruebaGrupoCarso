//
//  Search.swift
//  PruebaTecnicaGrupoCarso
//
//  Created by MacBookMBA9 on 27/03/23.
//

import Foundation

//Nombre, numero
struct Pokemon: Codable {
    let abilities: [Ability]
    let baseExperience: Int
    let forms: [Species]
    let height: Int
    let id: Int
    let name: String
    let order: Int
    let species: Species
    let sprites: Sprites
    let stats: [Stat]
    let weight: Int
    let types: [TypeElement]

    enum CodingKeys: String, CodingKey {
        case abilities
        case baseExperience = "base_experience"
        case forms
        case height
        case id
        case name, order
        case species, sprites, stats, weight
        case types
    }
    
    init(abilities: [Ability], baseExperience: Int, forms: [Species], height: Int, id: Int, name: String, order: Int, species: Species, sprites: Sprites, stats: [Stat], weight: Int, types: [TypeElement]) {
        self.abilities = abilities
        self.baseExperience = baseExperience
        self.forms = forms
        self.height = height
        self.id = id
        self.name = name
        self.order = order
        self.species = species
        self.sprites = sprites
        self.stats = stats
        self.weight = weight
        self.types = types
    }
    
    init() {
        self.abilities = []
        self.baseExperience = 0
        self.forms = []
        self.height = 0
        self.id = 0
        self.name = ""
        self.order = 0
        self.species = Species()
        self.sprites = Sprites()
        self.stats = []
        self.weight = 0
        self.types = []
    }
}

struct Ability: Codable {
    let ability: Species
    let isHidden: Bool
    let slot: Int

    enum CodingKeys: String, CodingKey {
        case ability
        case isHidden = "is_hidden"
        case slot
    }
    
    init(ability: Species, isHidden: Bool, slot: Int) {
        self.ability = ability
        self.isHidden = isHidden
        self.slot = slot
    }
    
    init() {
        self.ability = Species()
        self.isHidden = false
        self.slot = 0
    }
}

struct Species: Codable {
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

class Sprites: Codable {
    let frontDefault: String
    let frontShiny: String

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
    }

    init(frontDefault: String, frontShiny: String) {
        self.frontDefault = frontDefault
        self.frontShiny = frontShiny
    }
    
    init() {
        self.frontDefault = ""
        self.frontShiny = ""
    }
}

struct Stat: Codable {
    let baseStat, effort: Int
    let stat: Species

    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort, stat
    }
    
    init(baseStat: Int, effort: Int, stat: Species) {
        self.baseStat = baseStat
        self.effort = effort
        self.stat = stat
    }
    
    init() {
        self.baseStat = 0
        self.effort = 0
        self.stat = Species()
    }
}

struct TypeElement: Codable {
    let slot: Int
    let type: Species
    
    enum CodingKeys: String, CodingKey {
        case slot
        case type
    }
    
    init(slot: Int, type: Species) {
        self.slot = slot
        self.type = type
    }
    
    init(){
        self.slot = 0
        self.type = Species()
    }
}
