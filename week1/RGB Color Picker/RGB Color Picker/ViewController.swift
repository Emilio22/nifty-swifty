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
    
    @IBOutlet weak var resetBtn: UIButton!
    @IBOutlet weak var setColorBtn: UIButton!
    
    @IBOutlet weak var modeLabel: UILabel!
    
    
    
    // Initialize values for each slider
    var topValue : Float = 0.0,
        bottomValue : Float = 0.0,
        midValue : Float = 0.0
    
    // 0 - RGB, 1 - HSB
    var selectedIndex : Int = 0
    
    //Constant to determin how what background is too bright for light font
    let tooBright : Float = 400.00

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        updateColors()
    }
    
    @IBAction func modeChanged(_ sender: UISegmentedControl) {
        selectedIndex = sender.selectedSegmentIndex
        resetValues()
        adjustLabelText()
        adjustSliderRanges()
    }
    
    
    @IBAction func topSliderChanged(_ sender: UISlider) {
        topValue = sender.value.rounded()
        updateSliderValueLabels()
        updateColors()
    }
    
    @IBAction func midSliderChanged(_ sender: UISlider) {
        midValue = sender.value.rounded()
        updateSliderValueLabels()
        updateColors()
    }
    
    @IBAction func bottomSliderChanged(_ sender: UISlider) {
        bottomValue = sender.value.rounded()
        updateSliderValueLabels()
        updateColors()
    }
    
    @IBAction func resetPressed(_ sender: UIButton) {
        resetValues()
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
    
    func resetValues(){
        bottomValue = 0
        topValue = 0
        midValue = 0
        bottomSlider.value = 0
        topSlider.value = 0
        midSlider.value = 0
        updateSliderValueLabels()
        updateColors()
        colorLabel.text = "Pick a Color"
    }
    
    func updateSliderValueLabels() {
        topValueLabel.text = String(format: "%.0f", topValue)
        midValueLabel.text = String(format: "%.0f", midValue)
        bottomValueLabel.text = String(format: "%.0f", bottomValue)
    }
    
    func updateColors(){
        //convert values to CGFloats for UIColor.init
        let cgTop = CGFloat(topValue / topSlider.maximumValue)
        let cgMid = CGFloat(midValue / midSlider.maximumValue)
        let cgBottom = CGFloat(bottomValue / bottomSlider.maximumValue)
        let cgAlpha = CGFloat(1.0)

        //Adjust color of labels depending on background color
        adjustLabelColors()
        
        //Change background
        //if selectedIndex = 0 then RGB, else HSB
        if selectedIndex == 0{
            self.view.backgroundColor = UIColor.init(displayP3Red: cgTop, green: cgMid, blue: cgBottom, alpha: cgAlpha)
        } else {
            self.view.backgroundColor = UIColor.init(hue: cgTop, saturation: cgMid, brightness: cgBottom, alpha: cgAlpha)
        }
        
    }
    
    func adjustLabelText(){
        //if selectedIndex = 0 then RGB, else HSB
        if selectedIndex == 0 {
            topNameLabel.text = "R :"
            midNameLabel.text = "G :"
            bottomNameLabel.text = "B :"
            modeLabel.text = "Red, Green, Blue"
        } else {
            topNameLabel.text = "H :"
            midNameLabel.text = "S :"
            bottomNameLabel.text = "B :"
            modeLabel.text = "Hue, Saturation, Brightness"
        }
    }
    
    func adjustSliderRanges(){
        //if selectedIndex = 0 then RGB, else HSB
        if selectedIndex == 0{
            // All max values for RGB should be 256
            topSlider.maximumValue = 256
            midSlider.maximumValue = 256
            bottomSlider.maximumValue = 256
        } else {
            // Hue range is 0 - 360
            topSlider.maximumValue = 360
            // Saturation and Brightness is 0 - 100
            midSlider.maximumValue = 100
            bottomSlider.maximumValue = 100
        }
    }
    
    func adjustLabelColors(){
        
        let colorSum = topValue + midValue + bottomValue
        
        //if background is bright, change font to be dark
        //colorSum assumes RGB is selected, if HSB is selected, the brightness will evaluated
        if colorSum > tooBright || (selectedIndex == 1 && bottomValue > 50) {
            colorLabel.textColor = UIColor.black
            topValueLabel.textColor = UIColor.black
            midValueLabel.textColor = UIColor.black
            bottomValueLabel.textColor = UIColor.black
            topNameLabel.textColor = UIColor.black
            midNameLabel.textColor = UIColor.black
            bottomNameLabel.textColor = UIColor.black
            modeLabel.textColor = UIColor.black
            
            resetBtn.setTitleColor(.black, for: .normal)
            setColorBtn.setTitleColor(.black, for: .normal)
            
        } else {
            colorLabel.textColor = UIColor.white
            topValueLabel.textColor = UIColor.white
            midValueLabel.textColor = UIColor.white
            bottomValueLabel.textColor = UIColor.white
            topNameLabel.textColor = UIColor.white
            midNameLabel.textColor = UIColor.white
            bottomNameLabel.textColor = UIColor.white
            modeLabel.textColor = UIColor.white
            
            resetBtn.setTitleColor(.systemBlue, for: .normal)
            setColorBtn.setTitleColor(.systemBlue, for: .normal)
        }
        
        
    }
    
}

