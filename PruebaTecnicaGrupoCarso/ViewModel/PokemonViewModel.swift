//
//  PokemonViewModel.swift
//  PruebaTecnicaGrupoCarso
//
//  Created by MacBookMBA9 on 27/03/23.
//

import Foundation

class PokemonViewModel {
    var pokemonModel: Pokemones? = nil
    var search: Pokemon? = nil
    //var tipo: Tipo? = nil
    var especies: Especies? = nil
    
    func GetAllPokemon(pokemon: @escaping(Pokemones?, Error?) -> Void){
        let decoder = JSONDecoder()
        let urlSession = URLSession.shared
//        let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=100000&offset=0")
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon")
        
        urlSession.dataTask(with: url!) { data, response, error in
            //print("Data \(String(describing: data))")
            
            if let data = data {
                do {
                    var pok = Pokemones()
                    pok = try! decoder.decode(Pokemones.self, from: data)
                    pokemon(pok, nil)
                    
                }
            } else {
                pokemon(nil, error)
            }
        }.resume()
    }
    
    
    func previusPagination(url : String, pokemon: @escaping(Pokemones?, Error?) -> Void){
        let decoder = JSONDecoder()
        let urlSession = URLSession.shared

        let url = URL(string: url)
        
        urlSession.dataTask(with: url!) { data, response, error in
            print("Data \(String(describing: data))")
            if let data = data {
                do {
                    var pok = Pokemones()
                    pok = try! decoder.decode(Pokemones.self, from: data)
                    pokemon(pok, nil)
                }
            } else {
                pokemon(nil, error)
            }
        }.resume()
    }
    
    func nextPagination(url : String,  pokemon: @escaping(Pokemones?, Error?) -> Void){
        let decoder = JSONDecoder()
        let urlSession = URLSession.shared
        let url = URL(string: url)
        
        urlSession.dataTask(with: url!) { data, response, error in
            print("Data \(String(describing: data))")
            
            if let data = data {
                do {
                    var pok = Pokemones()
                    pok = try! decoder.decode(Pokemones.self, from: data)
                    pokemon(pok, nil)
                }
            } else {
                pokemon(nil, error)
            }
        }.resume()
    }
    
    func SearchNombre(nombre: String, pokemon: @escaping(Pokemon?, Error?) -> Void){
        let decoder = JSONDecoder()
        let urlSession = URLSession.shared
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(nombre)")
        
        urlSession.dataTask(with: url!) { data, response, error in
            print("Data \(String(describing: data))")
            
            if let data = data {
                do {
                    var pok = Pokemon()
                    pok = try! decoder.decode(Pokemon.self, from: data)
                    pokemon(pok, nil)
                }
            } else {
                pokemon(nil, error)
            }
        }.resume()
    }
    
    func SearchNumero(numero: Int, pokemon: @escaping(Pokemon?, Error?) -> Void){
        let decoder = JSONDecoder()
        let urlSession = URLSession.shared
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(numero)")
        
        urlSession.dataTask(with: url!) { data, response, error in
            print("Data \(String(describing: data))")
            
            if let data = data {
                do {
                    var pok = Pokemon()
                    pok = try! decoder.decode(Pokemon.self, from: data)
                    pokemon(pok, nil)
                }
            } else {
                pokemon(nil, error)
            }
        }.resume()
    }
    
    func SearchTipo(tipo: String, pokemon: @escaping(Especies?, Error?) -> Void){
        let decoder = JSONDecoder()
        let urlSession = URLSession.shared
        let url = URL(string: "https://pokeapi.co/api/v2/type/\(tipo)")
        
        urlSession.dataTask(with: url!) { data, response, error in
            print("Data \(String(describing: data))")
            
            if let data = data {
                do {
                    var pok = Especies()
                    pok = try! decoder.decode(Especies.self, from: data)
                    pokemon(pok, nil)
                }
            } else {
                pokemon(nil, error)
            }
        }.resume()
    }
    
    func DetallePokemon(idPokemon: String, pokemon: @escaping(Pokemon?, Error?) -> Void){
        let decoder = JSONDecoder()
        let urlSession = URLSession.shared
        
        if idPokemon == ""{
            let url = URL(string: "https://pokeapi.co/api/v2/pokemon\(idPokemon)")
            
            urlSession.dataTask(with: url!) { data, response, error in
                print("Data \(String(describing: data))")
                
                if let data = data {
                    do {
                        var pok = Pokemon()
                        pok = try! decoder.decode(Pokemon.self, from: data)
                        pokemon(pok, nil)
                    }
                } else {
                    pokemon(nil, error)
                }
            }.resume()
        } else {
            let url = URL(string: idPokemon)
            
            urlSession.dataTask(with: url!) { data, response, error in
                print("Data \(String(describing: data))")
                
                if let data = data {
                    do {
                        var pok = Pokemon()
                        pok = try! decoder.decode(Pokemon.self, from: data)
                        pokemon(pok, nil)
                    }
                } else {
                    pokemon(nil, error)
                }
            }.resume()
        }
       
       
    }
    
}
