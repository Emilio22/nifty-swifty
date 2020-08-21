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
    
    
    var cocktail: Cocktail
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.estimatedRowHeight = 60.0
        tableView.rowHeight = UITableView.automaticDimension;
        
        //Some items will have no measurement, adding space prevents crash
        if (cocktail.measurements.count < cocktail.ingredients.count) {
            cocktail.measurements.append(" ")
        }
        updateView()
        
    }
    
    init?(coder: NSCoder, cocktail: Cocktail) {
        self.cocktail = cocktail
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    func updateView() {
        nameLabel.text = cocktail.drinkName
        
        //check if there is a saved image or not
        if cocktail.savedImage == nil {
            let url = URL(string: cocktail.imageString)
            imageView.kf.setImage(with: url)
        } else {
            imageView.image = cocktail.savedImage
        }
        instructionsLabel.text = cocktail.instructions
    }
    
}


//MARK:- TableView
extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cocktail.getIngredients().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientMeasurementCell", for: indexPath)
        cell.textLabel?.text = "\(cocktail.measurements[indexPath.row]) \(cocktail.ingredients[indexPath.row])"
        return cell
    }
    
    
}
