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
    
    var drinks: [Cocktail] = []

    
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
                    self.drinks.append(cocktail)
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
                        self.drinks.append(cocktail)
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
    @IBSegueAction func showDetailView(_ coder: NSCoder) -> DetailViewController? {
        guard let indexPath = tableView.indexPathForSelectedRow else { fatalError() }
        let cocktail = drinks[indexPath.row]
        return DetailViewController(coder: coder, cocktail: cocktail)
    }
    @IBSegueAction func showSearchView(_ coder: NSCoder) -> SearchViewController? {
        return SearchViewController(coder: coder, drinks: drinks)
    }
}


// MARK:- Tableview
extension DrinksViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drinks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(CocktailCell.self)", for: indexPath) as? CocktailCell else { fatalError() }
        let cocktail = drinks[indexPath.row]
        let url = URL(string: cocktail.imageString)
        
        cell.nameLabel.text = cocktail.drinkName
        cell.cockTailThumbNail.kf.setImage(with: url)
        
        
        return cell
    }
    

}
