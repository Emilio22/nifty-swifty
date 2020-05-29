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
    @IBOutlet weak var greenLabel: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var blueLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func redSliderChanged(_ sender: UISlider) {
    }
    
    @IBAction func greenSliderChanged(_ sender: UISlider) {
    }
    
    @IBAction func blueSliderChanged(_ sender: UISlider) {
    }
    
    @IBAction func resetPressed(_ sender: UIButton) {
    }
    
    @IBAction func setColorPressed(_ sender: UIButton) {
    }
    
}

