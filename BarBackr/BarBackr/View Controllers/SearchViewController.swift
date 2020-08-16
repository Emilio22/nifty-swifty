//
//  SearchViewController.swift
//  BarBackr
//
//  Created by Emilio Rodriguez on 8/15/20.
//  Copyright © 2020 RWbc Emilio. All rights reserved.
//

import UIKit

class SearchViewController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    let drinks : [Cocktail]
    var searchResults : [Cocktail] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.placeholder = "Search Cocktail"
    }
    
    init?(coder: NSCoder, drinks: [Cocktail]) {
        self.drinks = drinks
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) { fatalError() }

    
    func searchCocktail(searchText: String){
        Networking.sharedInstance.searchCocktail(searchPath: searchText) { (result) in
            do {
                let results = try result.get()
                DispatchQueue.main.async {
                    self.searchResults = results.drinks
                    self.tableView.reloadData()
                }
            } catch {
                print(result)
                self.clearResults()
            }
        }
    }
    
    func clearResults() {
        DispatchQueue.main.async {
            self.searchResults = []
            self.tableView.reloadData()
        }
    }
    
    @IBSegueAction func showDetails(_ coder: NSCoder) -> DetailViewController? {
        guard let indexPath = tableView.indexPathForSelectedRow else { fatalError() }
        let cocktail = searchResults[indexPath.row]
        return DetailViewController(coder: coder, cocktail: cocktail)
    }
    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Result Cell", for: indexPath) as UITableViewCell
        
        let cocktail = searchResults[indexPath.row]
        cell.textLabel?.text = cocktail.drinkName
        
        return cell
    }

}

// MARK:- Searchbar Delegate
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            clearResults()
        } else {
            //replace spaces with underscore so the string can make a proper path
            let formatedSearchText = searchText.replacingOccurrences(of: " ", with: "_")
            searchCocktail(searchText: formatedSearchText)
        }
    }
    
}
