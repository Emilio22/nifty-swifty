//
//  SearchViewController.swift
//  BarBackr
//
//  Created by Emilio Rodriguez on 8/15/20.
//  Copyright © 2020 RWbc Emilio. All rights reserved.
//

import UIKit



class SearchViewController: UITableViewController, UINavigationControllerDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    var drinksManager : DrinksMananger
    var searchResults : [Cocktail] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.placeholder = "Search Cocktail"
        tableView.rowHeight = 55
    }
    
    init?(coder: NSCoder, drinks: DrinksMananger) {
        self.drinksManager = drinks
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) { fatalError() }

    
    //MARK:- Functions
    //search cocktail
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
    
    //clear results
    func clearResults() {
        DispatchQueue.main.async {
            self.searchResults = []
            self.tableView.reloadData()
        }
    }
    

    
    // MARK:- Segues
    @IBSegueAction func showDetails(_ coder: NSCoder) -> DetailViewController? {
        guard let indexPath = tableView.indexPathForSelectedRow else { fatalError() }
        let cocktail = searchResults[indexPath.row]
        return DetailViewController(coder: coder, cocktail: cocktail)
    }
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath) as? SearchResultCell else { fatalError() }
        
        let cocktail = searchResults[indexPath.row]
        cell.cocktailNameLabel.text = cocktail.drinkName
        cell.cocktail = cocktail
        cell.delegate = self
        
        return cell
    }
}

// MARK:- SearchResultCell Delegate
extension SearchViewController: SearchResultCellDelegate {
    func searchResultTableCell(_ searchResultTableCell: SearchResultCell, addButtonTappedFor cocktail: Cocktail) {
        drinksManager.drinks.append(cocktail)
        print("drink added")
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
