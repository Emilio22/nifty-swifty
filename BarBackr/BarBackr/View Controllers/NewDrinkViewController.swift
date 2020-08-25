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
    
    var drinksManager: DrinksMananger
    
    let textPicker = UIPickerView()
    
    
    var name: String = ""
    var savedImgPath: String = ""
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
        qtyTextField.inputView = textPicker
        textPicker.delegate = self
 
    }
    
    init?(coder: NSCoder, drinks: DrinksMananger) {
        self.drinksManager = drinks
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    @IBAction func addPressed(_ sender: Any) {
  
        guard let newCocktialName = nameLabel.text else{
            print("could not get name")
            return
            
        }
        guard let instructions = instructionsText.text else {
            print("Could not get instructions")
            return
        }
        guard let image = UIImage(contentsOfFile: savedImgPath) else {
            print("Could not get image")
            return
        }
        
        let newCocktail = Cocktail(drinkName: newCocktialName,
                                   imageString: "",
                                   ingredient1: nil, ingredient2: nil, ingredient3: nil, ingredient4: nil, ingredient5: nil, ingredient6: nil, ingredient7: nil, ingredient8: nil, ingredient9: nil, ingredient10: nil, measurement1: nil, measurement2: nil, measurement3: nil, measurement4: nil, measurement5: nil, measurement6: nil, measurement7: nil, measurement8: nil, measurement9: nil, measurement10: nil,
                                   instructions: instructions,
                                   savedImage: image,
                                   ingredients: ingredients,
                                   measurements: measurements)
        
        
        drinksManager.drinks.append(newCocktail)
        print("Cocktail added")
        //return to last view controller
        _ = navigationController?.popViewController(animated: true)
    
    }
    
    @IBAction func updateImagePressed(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }
    
    
    @IBAction func addIngredientPushed(_ sender: UIButton) {
        
        if (qtyTextField.text == "") || (ingredientTextField.text == "") {
            return
        }
        
        if let measurementString = qtyTextField.text,
            let ingredientString = ingredientTextField.text {
            ingredients.append(ingredientString)
            measurements.append(measurementString)
            print("Ingredient Added")
            DispatchQueue.main.async {
                self.qtyTextField.text = ""
                self.ingredientTextField.text = ""
                self.tableView.reloadData()
            }
        }
    }
    
    func updateView(){
        imageView.image = UIImage(contentsOfFile: savedImgPath)
    }
    
}

//MARK:- Image Picker
extension NewDrinkViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.editedImage] as? UIImage else { return }

        //create unique identifier for the image name
        let imageName = UUID().uuidString
        let imagePath = FileManager.documentDirectoryURL.appendingPathComponent(imageName)

        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
        savedImgPath = imagePath.path
        updateView()
        dismiss(animated: true)
    }

}

// MARK:- Table View
extension NewDrinkViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewIngredient") else { fatalError() }
        cell.textLabel?.text = measurements[indexPath.row] + " " + ingredients[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            ingredients.remove(at: indexPath.row)
            measurements.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}


// MARK:- Picker View
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
