//
//  ViewController.swift
//  RGB Color Picker
//
//  Created by Emilio Rodriguez on 5/29/20.
//  Copyright © 2020 RWbc Emilio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var blueLabel: UILabel!
    
    @IBOutlet weak var rLabel: UILabel!
    @IBOutlet weak var gLabel: UILabel!
    @IBOutlet weak var bLabel: UILabel!
    
    
    // Initialize values for each slider
    var redValue : Float = 0.0,
        blueValue : Float = 0.0,
        greenValue : Float = 0.0
    
    var colorName : String = ""
    
    //Constant to determin how bright the background is
    let tooBright : Float = 600.00
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        updateColors()
    }
    
    

    @IBAction func redSliderChanged(_ sender: UISlider) {
        redValue = sender.value.rounded()
        redLabel.text = String(redValue)
    }
    
    @IBAction func greenSliderChanged(_ sender: UISlider) {
        greenValue = sender.value.rounded()
        greenLabel.text = String(greenValue)
    }
    
    @IBAction func blueSliderChanged(_ sender: UISlider) {
        blueValue = sender.value.rounded()
        blueLabel.text = String(blueValue)
    }
    
    @IBAction func resetPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func setColorPressed(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: "What is this color?", message: nil, preferredStyle: .alert)
        alertController.addTextField()
        let action = UIAlertAction(title: "Colorize", style: .default, handler:{
            action in
            self.colorName = alertController.textFields![0].text!
            self.updateColors()
        })
        
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
        
    }
    
    func updateColors(){
        let cgRed = CGFloat(redValue / redSlider.maximumValue)
        let cgGreen = CGFloat(greenValue / greenSlider.maximumValue)
        let cgBlue = CGFloat(blueValue / blueSlider.maximumValue)
        let cgAlpha = CGFloat(1.0)
        let rgbSum = redValue + greenValue + blueValue
        colorLabel.text = colorName
        
        //if background is bright, change font to be dark
        if rgbSum > tooBright{
            
        }
        
        self.view.backgroundColor = UIColor.init(displayP3Red: cgRed, green: cgGreen, blue: cgBlue, alpha: cgAlpha)
    }
    
}

