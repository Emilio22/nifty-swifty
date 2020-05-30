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
    @IBOutlet weak var topSlider: UISlider!
    @IBOutlet weak var topValueLabel: UILabel!
    @IBOutlet weak var midSlider: UISlider!
    @IBOutlet weak var midValueLabel: UILabel!
    @IBOutlet weak var bottomSlider: UISlider!
    @IBOutlet weak var bottomValueLabel: UILabel!
    
    @IBOutlet weak var topNameLabel: UILabel!
    @IBOutlet weak var midNameLabel: UILabel!
    @IBOutlet weak var bottomNameLabel: UILabel!
    
    @IBOutlet weak var selectedSegmentIndex: UISegmentedControl!
    
    
    // Initialize values for each slider
    var topValue : Float = 0.0,
        bottomValue : Float = 0.0,
        midValue : Float = 0.0
    
    //Constant to determin how what background is too bright for light font
    let tooBright : Float = 430.00
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        updateColors()
    }
    
    
    @IBAction func topSliderChanged(_ sender: UISlider) {
        topValue = sender.value.rounded()
        updateLabels()
        updateColors()
    }
    
    @IBAction func midSliderChanged(_ sender: UISlider) {
        midValue = sender.value.rounded()
        updateLabels()
        updateColors()
    }
    
    @IBAction func bottomSliderChanged(_ sender: UISlider) {
        bottomValue = sender.value.rounded()
        updateLabels()
        updateColors()
    }
    
    @IBAction func resetPressed(_ sender: UIButton) {
        bottomValue = 0
        topValue = 0
        midValue = 0
        bottomSlider.value = 0
        topSlider.value = 0
        midSlider.value = 0
        updateLabels()
        updateColors()
        colorLabel.text = "Pick a Color"
    }
    
    @IBAction func setColorPressed(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: "What is this color?", message: nil, preferredStyle: .alert)
        alertController.addTextField()
        let action = UIAlertAction(title: "Colorize", style: .default, handler:{
            action in
            
            self.colorLabel.text = alertController.textFields![0].text
            
            self.updateColors()
        })
        
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
        
    }
    
    func updateLabels() {
        bottomValueLabel.text = String(bottomValue)
        topValueLabel.text = String(topValue)
        midValueLabel.text = String(midValue)
    }
    
    func updateColors(){
        //convert values to CGFloats for UIColor.init
        let cgRed = CGFloat(topValue / topSlider.maximumValue)
        let cgGreen = CGFloat(midValue / midSlider.maximumValue)
        let cgBlue = CGFloat(bottomValue / bottomSlider.maximumValue)
        let cgAlpha = CGFloat(1.0)
        let rgbSum = topValue + midValue + bottomValue
        
        //if background is bright, change font to be dark
        if rgbSum > tooBright {
            colorLabel.textColor = UIColor.black
            topValueLabel.textColor = UIColor.black
            midValueLabel.textColor = UIColor.black
            bottomValueLabel.textColor = UIColor.black
            topNameLabel.textColor = UIColor.black
            midNameLabel.textColor = UIColor.black
            bottomNameLabel.textColor = UIColor.black
            
        } else {
            colorLabel.textColor = UIColor.white
            topValueLabel.textColor = UIColor.white
            midValueLabel.textColor = UIColor.white
            bottomValueLabel.textColor = UIColor.white
            topNameLabel.textColor = UIColor.white
            midNameLabel.textColor = UIColor.white
            bottomNameLabel.textColor = UIColor.white
        }
        
        //Change background
        self.view.backgroundColor = UIColor.init(displayP3Red: cgRed, green: cgGreen, blue: cgBlue, alpha: cgAlpha)
    }
    
}

