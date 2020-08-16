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

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
        let cocktail: Cocktail
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = cocktail.drinkName
        let url = URL(string: cocktail.imageString)
        imageView.kf.setImage(with: url)
        
        print(cocktail.getIngredients())
        print(cocktail.getMeasurements())
        
    }
    
    init?(coder: NSCoder, cocktail: Cocktail) {
        self.cocktail = cocktail
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    
}
