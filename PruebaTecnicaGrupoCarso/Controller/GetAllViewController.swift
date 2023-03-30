//
//  ViewController.swift
//  PruebaTecnicaGrupoCarso
//
//  Created by user238353 on 3/26/23.
//

import UIKit
import iOSDropDown
import Hex

class GetAllViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var DropDownTipo: DropDown!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // self.view.backgroundColor = UIColor(hex: color ?? "")
    
    let pokemonViewModel = PokemonViewModel()
    var pokemonesModel: Pokemones? = nil
    var pokemonModel: Pokemon? = nil
    var especieModel: Especies? = nil
    var tipoModel: Tipo? = nil
    
    var idBusqueda: Int = 0
    var searchNombre: String = ""
    var dropId: [Int] = [1, 2, 3]
    var dropArray: [String] = ["Nombre", "Número", "Tipo"]
    var urlPokemon: String = ""
    var idPokemon: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "GetAllCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PokemonCell")
        
        DropDownTipo.optionArray = [String]()
        DropDownTipo.optionIds = [Int]()
        
        DropDownTipo.didSelect{ selected, index, id in
            self.idBusqueda = id
        }
        
        loadDrop()
        //loadBackground()
    }
    
    func loadDrop(){
        for name in dropArray {
            DropDownTipo.optionArray.append(name)
        }
        
        for id in dropId {
            DropDownTipo.optionIds?.append(id)
        }
       
    }
    
    /*func loadBackground(){
        pokemonViewModel.SearchTipo(tipo: "water", pokemon: { request, error in
            if let requestData = request {
                DispatchQueue.main.async {
                    self.especieModel = requestData
                    print(self.especieModel)
                    
                    self.collectionView.reloadData()
                }
            }
            
            if let error = error {
                let alert = UIAlertController(title: "Alert", message: "Error al consultar los pokemones", preferredStyle: .alert)
                
                let aceptar = UIAlertAction(title: "Aceptar", style: .default)
                
                alert.addAction(aceptar)
                self.present(alert, animated: false)
            }
        })
    }*/
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detalle" {
            let detalleViewController = segue.destination as! DetalleViewController
            detalleViewController.idPokemon = self.idPokemon
            detalleViewController.urlPokemon = self.urlPokemon
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    func loadData(){
        pokemonViewModel.GetAllPokemon(pokemon: { request, error in
            if let requestData = request {
                DispatchQueue.main.async {
                    self.pokemonesModel = requestData
                    //print(self.pokemonesModel)
                    self.collectionView.reloadData()
                }
            }
            
            if let error = error {
                let alert = UIAlertController(title: "Alert", message: "Error al consultar los pokemones", preferredStyle: .alert)
                
                let aceptar = UIAlertAction(title: "Aceptar", style: .default)
                
                alert.addAction(aceptar)
                self.present(alert, animated: false)
            }
        })
    }
    
    @IBAction func btnSearch(_ sender: UIButton) {
        if idBusqueda == 1{
            pokemonViewModel.SearchNombre(nombre: txtSearch.text!, pokemon: { request, error in
                if let requestData = request {
                    DispatchQueue.main.async {
                        self.pokemonModel = requestData
                        print(self.pokemonModel)
                        self.collectionView.reloadData()
                    }
                }
                
                if let error = error {
                    let alert = UIAlertController(title: "Alert", message: "Error al consultar los pokemones", preferredStyle: .alert)
                    
                    let aceptar = UIAlertAction(title: "Aceptar", style: .default)
                    
                    alert.addAction(aceptar)
                    self.present(alert, animated: false)
                }
            })
        } else if idBusqueda == 2{
            let txtBusqueda = Int(txtSearch.text!)!
            print(txtBusqueda)
            pokemonViewModel.SearchNumero(numero: txtBusqueda, pokemon: { request, error in
                if let requestData = request {
                    DispatchQueue.main.async {
                        self.pokemonModel = requestData
                        print(self.pokemonModel?.name)
                        self.collectionView.reloadData()
                    }
                }
                
                if let error = error {
                    let alert = UIAlertController(title: "Alert", message: "Error al consultar los pokemones", preferredStyle: .alert)
                    
                    let aceptar = UIAlertAction(title: "Aceptar", style: .default)
                    
                    alert.addAction(aceptar)
                    self.present(alert, animated: false)
                }
            })
        } else if idBusqueda == 3{
            //print(txtSearch.text)
            pokemonViewModel.SearchTipo(tipo: txtSearch.text!, pokemon: { request, error in
                if let requestData = request {
                    DispatchQueue.main.async {
                        self.especieModel = requestData
                        print(self.especieModel)
                        self.collectionView.reloadData()
                    }
                }
                
                if let error = error {
                    let alert = UIAlertController(title: "Alert", message: "Error al consultar los pokemones", preferredStyle: .alert)
                    
                    let aceptar = UIAlertAction(title: "Aceptar", style: .default)
                    
                    alert.addAction(aceptar)
                    self.present(alert, animated: false)
                }
            })
        } else {
            pokemonViewModel.GetAllPokemon(pokemon: { request, error in
                if let requestData = request {
                    DispatchQueue.main.async {
                        self.pokemonesModel = requestData
                        print("GetAll", self.pokemonesModel?.results.count)
                        self.collectionView.reloadData()
                    }
                }
                
                if let error = error {
                    let alert = UIAlertController(title: "Alert", message: "Error al consultar los pokemones", preferredStyle: .alert)
                    
                    let aceptar = UIAlertAction(title: "Aceptar", style: .default)
                    
                    alert.addAction(aceptar)
                    self.present(alert, animated: false)
                }
            })
        }
    }
    
    @IBAction func btnPrevios(_ sender: UIButton) {
        //print("Previus")
        pokemonViewModel.previusPagination(url: (pokemonesModel?.previous)!, pokemon: { request, error in
            if let requestData = request {
                DispatchQueue.main.async {
                    self.pokemonesModel = requestData
                    print(self.pokemonesModel)
                    self.collectionView.reloadData()
                }
            }
            
            if let error = error {
                let alert = UIAlertController(title: "Alert", message: "Error al consultar los pokemones", preferredStyle: .alert)
                
                let aceptar = UIAlertAction(title: "Aceptar", style: .default)
                
                alert.addAction(aceptar)
                self.present(alert, animated: false)
            }
        })
    }
    
    @IBAction func btnNext(_ sender: UIButton) {
        print("Next", pokemonesModel?.next)
        
        pokemonViewModel.nextPagination(url: (pokemonesModel?.next)!) { request, error in
            if let requestData = request {
                DispatchQueue.main.async {
                    self.pokemonesModel = requestData
                    print(self.pokemonesModel)
                    self.collectionView.reloadData()
                }
            }
            
            if let error = error {
                let alert = UIAlertController(title: "Alert", message: "Error al consultar los pokemones", preferredStyle: .alert)
                
                let aceptar = UIAlertAction(title: "Aceptar", style: .default)
                
                alert.addAction(aceptar)
                self.present(alert, animated: false)
            }
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if especieModel?.pokemon.count != nil{
            return especieModel?.pokemon.count ?? 0
        }else if pokemonModel != nil {
            return 1
        } else {
            return pokemonesModel?.results.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokemonCell", for: indexPath) as! GetAllCollectionViewCell
        
        cell.layer.cornerRadius = 5
        cell.backgroundColor = UIColor(hex: "#3899F8")
        
        print(indexPath.row)
        
        if especieModel?.pokemon.count != nil{
            cell.lblNombre.text = especieModel?.pokemon[indexPath.row].pokemon.name

            let num = especieModel?.pokemon[indexPath.row].pokemon.url
            let newNumero = num?.replacingOccurrences(of: "https://pokeapi.co/api/v2/pokemon/", with: "")
            let numero = newNumero?.replacingOccurrences(of: "/", with: "")

            cell.lblNumero.text = numero

            let url = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(numero!).png")
            DispatchQueue.global().async {
                guard let imageData = try? Data(contentsOf: url!)else{return}
                    let image = UIImage(data: imageData)
                    DispatchQueue.main.async {
                        cell.imgPokemon.image = image
                }
            }

        } else if pokemonModel != nil {
            cell.lblNombre.text = pokemonModel?.name
            cell.lblNumero.text! = "\(pokemonModel?.id ?? 0)"

            let url = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(pokemonModel?.id ?? 0).png")
            DispatchQueue.global().async {
                guard let imageData = try? Data(contentsOf: url!)else{return}
                    let image = UIImage(data: imageData)
                    DispatchQueue.main.async {
                        cell.imgPokemon.image = image
                }
            }
        } else {
//            print(pokemonesModel?.results.count)
            print(indexPath.row)
            cell.lblNombre.text = " \(pokemonesModel!.results[indexPath.row].name.prefix(1).capitalized)\(pokemonesModel!.results[indexPath.row].name.dropFirst())"

            let num = pokemonesModel?.results[indexPath.row].url
            let newNumero = num?.replacingOccurrences(of: "https://pokeapi.co/api/v2/pokemon/", with: "")
            let numero = newNumero?.replacingOccurrences(of: "/", with: "")

            cell.lblNumero.text = numero

            let url = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(numero!).png")!
            DispatchQueue.global().async {
                guard let imageData = try? Data(contentsOf: url)else{return}
                    let image = UIImage(data: imageData)
                    DispatchQueue.main.async {
                        cell.imgPokemon.image = image
                }
            }
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if especieModel?.pokemon.count != nil{
            self.urlPokemon = especieModel?.pokemon[indexPath.row].pokemon.url ?? ""
        } else if pokemonModel != nil {
            self.idPokemon = pokemonModel?.id ?? 0
        } else {
            self.urlPokemon = pokemonesModel?.results[indexPath.row].url ?? ""
        }
        
        performSegue(withIdentifier: "detalle", sender: self)
    }
}

 
