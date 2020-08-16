//
//  DetailViewController.swift
//  BarBackr
//
//  Created by Emilio Rodriguez on 8/15/20.
//  Copyright © 2020 RWbc Emilio. All rights reserved.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {


    @IBOutlet weak var tableView: IngredientsTableView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var instructionsLabel: UILabel!
    
    
    let cocktail: Cocktail
    var ingredients : [String] = []
    var measurements : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.estimatedRowHeight = 60.0
        tableView.rowHeight = UITableView.automaticDimension;
        
        ingredients = cocktail.getIngredients()
        measurements = cocktail.getMeasurements()
        
        //Some items will have no measurement, adding space prevents crash
        if (measurements.count < ingredients.count) {
            measurements.append(" ")
        }
        updateView()
        
        print(cocktail.getIngredients())
        print(cocktail.getMeasurements())
        print(cocktail.instructions)
        
    }
    
    init?(coder: NSCoder, cocktail: Cocktail) {
        self.cocktail = cocktail
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    func updateView() {
        nameLabel.text = cocktail.drinkName
        let url = URL(string: cocktail.imageString)
        imageView.kf.setImage(with: url)
        instructionsLabel.text = cocktail.instructions
    }
    
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cocktail.getIngredients().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientMeasurementCell", for: indexPath)
        cell.textLabel?.text = "\(measurements[indexPath.row]) \(ingredients[indexPath.row])"
        
        return cell
    }
    
    
}
