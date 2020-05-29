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
    
    // Initialize values for each slider
    var redValue = 0,
        blueValue = 0,
        greenValue = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    

    @IBAction func redSliderChanged(_ sender: UISlider) {
        redValue = Int(sender.value)
        redLabel.text = String(redValue)
    }
    
    @IBAction func greenSliderChanged(_ sender: UISlider) {
        greenValue = Int(sender.value)
        greenLabel.text = String(greenValue)
    }
    
    @IBAction func blueSliderChanged(_ sender: UISlider) {
        blueValue = Int(sender.value)
        blueLabel.text = String(blueValue)
    }
    
    @IBAction func resetPressed(_ sender: UIButton) {
    }
    
    @IBAction func setColorPressed(_ sender: UIButton) {
    }
    
}

