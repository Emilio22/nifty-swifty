//
//  ViewController.swift
//  BullsEye
//
//  Created by Ray Wenderlich on 6/13/18.
//  Copyright © 2018 Ray Wenderlich. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    var game = BullsEyeGame()
    
    var quickDiff: Int {
        return abs(game.targetValue - game.currentValue)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        game.currentValue = Int(slider.value.rounded())
        game.startNewGame()
        updateView()
    }
    
    
    @IBAction func showAlert() {
        
        game.calculatePoints()
        let alert = UIAlertController(title: game.title, message: game.message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: {
            action in
            self.game.startNewRound()
            self.updateView()
        })
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        game.currentValue = Int(slider.value.rounded())
        slider.minimumTrackTintColor = UIColor.blue.withAlphaComponent(CGFloat(quickDiff)/100)
    }
    
    @IBAction func startNewGame() {
        game.startNewGame()
        updateView()
    }
    
    func updateView() {
        targetLabel.text = String(game.targetValue)
        scoreLabel.text = String(game.score)
        roundLabel.text = String(game.round)
        slider.value = Float(game.currentValue)
        slider.minimumTrackTintColor = UIColor.blue.withAlphaComponent(CGFloat(quickDiff)/100)
    }
    
  
}



