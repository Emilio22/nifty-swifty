//
//  SandwichViewController.swift
//  SandwichSaturation
//
//  Created by Jeff Rames on 7/3/20.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//

import Combine
import UIKit
import CoreData

protocol SandwichDataSource {
  func saveSandwich(_: SandwichData)
}

class SandwichViewController: UITableViewController, SandwichDataSource {
  
  private let appDelegate = UIApplication.shared.delegate as! AppDelegate
  private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  
  let searchController = UISearchController(searchResultsController: nil)
  

  private var fetchedSandwichesController: NSFetchedResultsController<Sandwich>!
  
  var sandwiches = [Sandwich]()
  
  var sandwichesData = [SandwichData]()
  var filteredSandwiches = [SandwichData]()
  
  let defaults = UserDefaults.standard
  
  var query = ""
  var selectedSauce : SauceAmount?

  required init?(coder: NSCoder) {
    super.init(coder: coder)
  
    if !(defaults.bool(forKey: "isLoaded")){
      loadSandwiches()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
        
    let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(presentAddView(_:)))
    navigationItem.rightBarButtonItem = addButton
    
    // Setup Search Controller
    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Filter Sandwiches"
    navigationItem.searchController = searchController
    definesPresentationContext = true
    searchController.searchBar.scopeButtonTitles = SauceAmount.allCases.map { $0.rawValue }
    // set selected scope of search bar to last left selection stored on user defaults
    searchController.searchBar.selectedScopeButtonIndex = defaults.integer(forKey: "SelectedScope")
    searchController.searchBar.delegate = self
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    fetchSandwiches()
  }
  
  
  func loadSandwiches() {
    //grab json url
    guard let jsonURL = Bundle.main.url(forResource: "sandwiches", withExtension: "json") else {
      print("Could not find json file")
      return
    }
    
    //Decode JSON into sandwichData array
    let decoder = JSONDecoder()
    do {
      let sandwichData = try Data(contentsOf: jsonURL)
      sandwichesData = try decoder.decode([SandwichData].self, from: sandwichData)
    } catch let error {
      print(error)
    }
    
    //save data into core data
    sandwichesData.forEach { (data) in
      let sandwich = Sandwich(entity: Sandwich.entity(), insertInto: context)
      let sauceAmount = SauceAmountModel(entity: SauceAmountModel.entity(), insertInto: context)
      sauceAmount.sauceAmountString = data.sauceAmount.rawValue
      sandwich.name = data.name
      sandwich.imageName = data.imageName
      sandwich.sauceAmount = sauceAmount
      
      appDelegate.saveContext()
    }
    defaults.set(true, forKey: "isLoaded")
  }

  func saveSandwich(_ data: SandwichData) {
    let sandwich = Sandwich(entity: Sandwich.entity(), insertInto: context)
    let sauceAmount = SauceAmountModel(entity: SauceAmountModel.entity(), insertInto: context)
    sauceAmount.sauceAmountString = data.sauceAmount.rawValue
    sandwich.name = data.name
    sandwich.imageName = data.imageName
    sandwich.sauceAmount = sauceAmount

    appDelegate.saveContext()
    fetchSandwiches()
    tableView.reloadData()
  }
  
  private func fetchSandwiches() {
    let request = Sandwich.fetchRequest() as NSFetchRequest<Sandwich>
    let sauceString = selectedSauce?.rawValue
    
    
    
    if isFiltering {
      
      
      if selectedSauce == SauceAmount.any {
        request.predicate = NSPredicate(format: "name CONTAINS[cd] %@", query)
      } else if !(query.isEmpty){
        request.predicate = NSCompoundPredicate(type: .and,
                                                subpredicates: [
                                                  NSPredicate(format: "name CONTAINS[cd] %@", query),
                                                  NSPredicate(format: "sauceAmount.sauceAmountString == %@", sauceString! )
          ]
        )
      } else {
        request.predicate = NSPredicate(format: "sauceAmount.sauceAmountString == %@", sauceString! )
      }
      
    }
    
    do {
      sandwiches = try context.fetch(request)
    } catch let error as NSError {
      print("Could not fetch. \(error), \(error.userInfo)")
    }
  }

  @objc
  func presentAddView(_ sender: Any) {
    performSegue(withIdentifier: "AddSandwichSegue", sender: self)
  }
  
  // MARK: - Search Controller
  var isSearchBarEmpty: Bool {
    return searchController.searchBar.text?.isEmpty ?? true
  }
  
  func filterContentForSearchText(_ searchText: String, sauceAmount: SauceAmount? = nil) {
    if isSearchBarEmpty {
      query = ""
    } else {
      query = searchText
    }
    selectedSauce = sauceAmount
    fetchSandwiches()
    tableView.reloadData()
  }
  
  var isFiltering: Bool {
    let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
    return searchController.isActive && (!isSearchBarEmpty || searchBarScopeIsFiltering)
  }
  
  // MARK: - Table View
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

    return sandwiches.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "sandwichCell", for: indexPath) as? SandwichCell
      else { return UITableViewCell() }
    
    let sandwich = sandwiches[indexPath.row]

    cell.thumbnail.image = UIImage.init(imageLiteralResourceName: sandwich.imageName)
    cell.nameLabel.text = sandwich.name
    cell.sauceLabel.text = sandwich.sauceAmount.sauceAmountString

    return cell
  }
}

// MARK: - UISearchResultsUpdating
extension SandwichViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    
    let searchBar = searchController.searchBar
    let sauceAmount = SauceAmount(rawValue: searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex])

    filterContentForSearchText(searchBar.text!, sauceAmount: sauceAmount)
  }
}

// MARK: - UISearchBarDelegate
extension SandwichViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
    
    defaults.set(selectedScope, forKey: "SelectedScope")
    
    let sauceAmount = SauceAmount(rawValue: searchBar.scopeButtonTitles![selectedScope])
    filterContentForSearchText(searchBar.text!, sauceAmount: sauceAmount)
  }
}

