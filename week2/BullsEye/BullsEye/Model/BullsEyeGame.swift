//
//  BullsEyeGame.swift
//  BullsEye
//
//  Created by Emilio Rodriguez on 6/7/20.
//  Copyright © 2020 Ray Wenderlich. All rights reserved.
//

import Foundation

struct BullsEyeGame {
    
    var currentValue = 0
    var targetValue = 0
    var score = 0
    var round = 0
    
    var title : String?
    var message : String?
    
    var difference: Int {
        return abs(targetValue - currentValue)
    }
   
    
    mutating func startNewGame(){
        score = 0
        round = 0
        startNewRound()
    }
    
    mutating func startNewRound(){
        round += 1
        targetValue = Int.random(in: 1...100)
        currentValue = 50
    }
    
    mutating func calculatePoints(){
        
        var points = 100 - difference
        
        if difference == 0 {
          title = "Perfect!"
          points += 100
        } else if difference < 5 {
          title = "You almost had it!"
          if difference == 1 {
            points += 50
          }
        } else if difference < 10 {
          title = "Pretty good!"
        } else {
          title = "Not even close..."
        }
        
        message = "You scored \(points) points"
        score += points
        
    }
    
    
}
