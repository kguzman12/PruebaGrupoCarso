//
//  DetalleViewController.swift
//  PruebaTecnicaGrupoCarso
//
//  Created by MacBookMBA9 on 27/03/23.
//

import UIKit

class DetalleViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var info: UIView!
    @IBOutlet weak var lblNobre: UILabel!
    @IBOutlet var principalView: UIView!
    @IBOutlet weak var lblNumero: UILabel!
    @IBOutlet weak var spriteFrontal: UIImageView!
    @IBOutlet weak var spritSiny: UIImageView!
    @IBOutlet weak var speed: UIProgressView!
    @IBOutlet weak var defense: UIProgressView!
    @IBOutlet weak var defenseSpecial: UIProgressView!
    
    let pokemonViewModel = PokemonViewModel()
    var pokemonesModel: Pokemones? = nil
    var pokemonModel: Pokemon? = nil
    var urlPokemon: String = ""
    var idPokemon: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tipo = Tipo()
        
        
        let rectShape = CAShapeLayer()
        rectShape.bounds = info.frame
        rectShape.position = info.center
        rectShape.path = UIBezierPath(roundedRect: self.info.bounds, byRoundingCorners: [.topLeft , .topRight], cornerRadii: CGSize(width: 50, height: 50)).cgPath
        
        info.layer.mask = rectShape
        
    
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    func loadData(){
        if urlPokemon == ""{
            pokemonViewModel.DetallePokemon(idPokemon: String(idPokemon), pokemon: { request, error in
                if let requestData = request {
                    DispatchQueue.main.async {
                        self.pokemonModel = requestData
                        print(self.pokemonModel)
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
            pokemonViewModel.DetallePokemon(idPokemon: urlPokemon, pokemon: { request, error in
                if let requestData = request {
                    DispatchQueue.main.async {
                        self.pokemonModel = requestData
                        
                        let url = URL(string: self.pokemonModel?.sprites.frontDefault ?? "")
                        DispatchQueue.global().async {
                            guard let imageData = try? Data(contentsOf: url!)else{return}
                                let image = UIImage(data: imageData)
                                DispatchQueue.main.async {
                                    self.spriteFrontal.image = image
                            }
                        }
                        
                        let url2 = URL(string: self.pokemonModel?.sprites.frontShiny ?? "")
                        DispatchQueue.global().async {
                            guard let imageData = try? Data(contentsOf: url2!)else{return}
                                let image = UIImage(data: imageData)
                                DispatchQueue.main.async {
                                    self.spritSiny.image = image
                            }
                        }
    
                        self.lblNobre.text = "\(self.pokemonModel!.name.prefix(1).capitalized)\(self.pokemonModel!.name.dropFirst())"
                
                        self.lblNumero.text = "\(self.pokemonModel!.id)"
                        
                        let num = self.pokemonModel?.stats[0].stat.url
                        let newNumero = num?.replacingOccurrences(of: "https://pokeapi.co/api/v2/stat/", with: "")
                        let numero = newNumero?.replacingOccurrences(of: "/", with: "")
//                        self.numeroStats.text = numero
                        
                        let color  = Tipo.Color[(self.pokemonModel?.types[0].type.name)!]
                        self.principalView.backgroundColor = UIColor(hex: color!)
                        self.speed.tintColor = UIColor(hex: color!)
                        print(self.pokemonModel!.stats[5].baseStat)
                        print(Float((self.pokemonModel!.stats[5].baseStat)) / 100.0)
                        self.speed.progress = Float((self.pokemonModel!.stats[5].baseStat)) / 100.0
                        self.defense.tintColor = UIColor(hex: color!)
                        self.defense.progress = Float((self.pokemonModel!.stats[2].baseStat)) / 100.0
                        self.defenseSpecial.tintColor = UIColor(hex: color!)
                        self.defenseSpecial.progress = Float((self.pokemonModel!.stats[4].baseStat)) / 100.0
                        
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
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemonModel?.types.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TipoCell", for: indexPath) as! TipoCollectionViewCell
        
        cell.lblNombre.text = pokemonModel?.types[indexPath.row].type.name
        
        let num = pokemonModel?.types[indexPath.row].type.url
        let newNumero = num?.replacingOccurrences(of: "https://pokeapi.co/api/v2/type/", with: "")
        let numero = newNumero?.replacingOccurrences(of: "/", with: "")
        cell.lblNumero.text = numero
        
        return cell
    }
    

}
