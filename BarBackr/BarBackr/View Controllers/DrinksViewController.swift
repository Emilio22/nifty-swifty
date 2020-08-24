//
//  ViewController.swift
//  BarBackr
//
//  Created by Emilio Rodriguez on 8/12/20.
//  Copyright © 2020 RWbc Emilio. All rights reserved.
//

import UIKit
import Kingfisher

class DrinksViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var drinksManager = DrinksMananger()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.rowHeight = 100
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    // MARK:- Random Cocktail
    @IBAction func getRandomCocktail(_ sender: UIButton) {
        Networking.sharedInstance.getRandomCocktail { (result) in
            do {
                let results = try result.get()
                DispatchQueue.main.async {
                    let cocktail = results.drinks[0]
                    self.drinksManager.drinks.append(cocktail)
                    self.tableView.reloadData()
                }
            } catch {
                print(result)
            }
        }
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        // code you want to implement
        if motion == .motionShake {
            Networking.sharedInstance.getRandomCocktail { (result) in
                do {
                    let results = try result.get()
                    DispatchQueue.main.async {
                        let cocktail = results.drinks[0]
                        self.drinksManager.drinks.append(cocktail)
                        self.tableView.reloadData()
                    }
                    self.tableView.reloadData()
                } catch {
                    print(result)
                }
            }
        }
    }
    
    // MARK:- Segues
    @IBSegueAction func showNewDrinkView(_ coder: NSCoder) -> NewDrinkViewController? {
        return NewDrinkViewController(coder: coder, drinks: self.drinksManager)
    }
    
    @IBSegueAction func showDetailView(_ coder: NSCoder) -> DetailViewController? {
        guard let indexPath = tableView.indexPathForSelectedRow else { fatalError() }
        let cocktail = drinksManager.drinks[indexPath.row]
        return DetailViewController(coder: coder, cocktail: cocktail)
    }
    
    @IBSegueAction func showSearchView(_ coder: NSCoder) -> SearchViewController? {
        return SearchViewController(coder: coder, drinks: self.drinksManager)
    }
}


// MARK:- Tableview
extension DrinksViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //if drinks is empty, show empty message
        if drinksManager.drinks.count == 0{
            self.tableView.setEmptyMessage("Search or Create a new Cocktail!")
        } else {
            self.tableView.restore()
        }
        return drinksManager.drinks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(CocktailCell.self)", for: indexPath) as? CocktailCell else { fatalError() }
        let cocktail = drinksManager.drinks[indexPath.row]
        let url = URL(string: cocktail.imageString)
        cell.nameLabel.text = cocktail.drinkName
        
        if cocktail.savedImage == nil{
            cell.cockTailThumbNail.kf.setImage(with: url)
        }
        else {
            cell.cockTailThumbNail.image = cocktail.savedImage
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            drinksManager.drinks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } 
    }
}

