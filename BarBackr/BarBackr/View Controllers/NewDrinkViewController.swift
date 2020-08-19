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
    
    let picker = UIPickerView()
    
    var name: String = ""
    var imgPath: String = ""
    var instructions: String = ""
    
    var ingredients: [String] = []
    var measurements: [String] = []
    
    //Values for picker
    let numberRange = Array(0...200)
    let fractions = ["","1/8","1/4","1/3","1/2","2/3","3/4"]
    let units = [
        "",
        "oz",
        "ml",
        "Dash",
        "tsp",
        "tbps",
        "cup",
        "Pint",
        "cL",
        "L",
        "Drop",
        "Pinch",
        "Splash"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set up Instructions Text View
        instructionsText.delegate = self
        instructionsText.text = "Add Instructions"
        instructionsText.textColor = UIColor.lightGray
        instructionsText.layer.borderWidth = 1
        instructionsText.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        //Picker View
        qtyTextField.inputView = picker
        picker.delegate = self
 
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


// MARK:- PickerView
extension NewDrinkViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return numberRange.count
        } else if component == 1 {
            return fractions.count
        } else {
            return units.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return String(numberRange[row])
        } else if component == 1 {
            return fractions[row]
        } else {
            return units[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let number = String(numberRange[pickerView.selectedRow(inComponent: 0)])
        let fraction = fractions[pickerView.selectedRow(inComponent: 1)]
        let unit = units[pickerView.selectedRow(inComponent: 2)]
        qtyTextField.text = number + " " + fraction + " " + unit
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
