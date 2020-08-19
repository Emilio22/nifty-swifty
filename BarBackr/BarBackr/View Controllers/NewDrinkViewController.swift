//
//  NewDrinkViewController.swift
//  BarBackr
//
//  Created by Emilio Rodriguez on 8/18/20.
//  Copyright © 2020 RWbc Emilio. All rights reserved.
//

import UIKit

class NewDrinkViewController: UIViewController {

    
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var qtyTextField: UITextField!
    @IBOutlet weak var ingredientTextField: UITextField!
    @IBOutlet weak var addIngredientButton: UIButton!
    
    @IBOutlet weak var instructionsText: UITextView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var name: String = ""
    var imgPath: String = ""
    var instructions: String = ""
    
    var ingredients: [String] = []
    var measurements: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        instructionsText.delegate = self
        instructionsText.text = "Add Instructions"
        instructionsText.textColor = UIColor.lightGray
        instructionsText.layer.borderWidth = 1
        instructionsText.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
 
    }
    
    @IBAction func updateImagePushed(_ sender: UIButton) {
    }
    
    
    @IBAction func addIngredientPushed(_ sender: UIButton) {
        if (ingredientTextField.text == "" || qtyTextField.text == ""){
        
        }
     
    }
    
}

// MARK:- TableView
extension NewDrinkViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewIngredient") else { fatalError() }
        
        return cell
    }
}


// MARK:- TextView
extension NewDrinkViewController: UITextViewDelegate {
    //Crete a placeholder
    func textViewDidBeginEditing(_ textView: UITextView) {
        if instructionsText.textColor == UIColor.lightGray {
            instructionsText.text = nil
            instructionsText.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if instructionsText.text.isEmpty {
            instructionsText.text = "Add Instructions"
            instructionsText.textColor = UIColor.lightGray
        }
    }
    
}
