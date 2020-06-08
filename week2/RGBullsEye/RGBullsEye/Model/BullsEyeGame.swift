/*
* Copyright (c) 2015 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import Foundation

let INITIAL_VAL = 127
let RANGE_MIN = 1
let RANGE_MAX = 255

struct BullsEyeGame {
    
    var currentRGB = RGB(r: INITIAL_VAL,
                         g: INITIAL_VAL,
                         b: INITIAL_VAL)
        
    var targetRGB = RGB(r: 0, g: 0, b: 0)
    
    
    var score = 0
    var round = 0
    
    var title : String?
    var message : String?
    
    
    mutating func startNewGame(){
        score = 0
        round = 0
        startNewRound()
    }
    
    mutating func startNewRound(){
        round += 1
        targetRGB = RGB(r: Int.random(in: RANGE_MIN...RANGE_MAX),
                        g: Int.random(in: RANGE_MIN...RANGE_MAX),
                        b: Int.random(in: RANGE_MIN...RANGE_MAX))
        
        currentRGB = RGB(r: INITIAL_VAL,
                         g: INITIAL_VAL,
                         b: INITIAL_VAL)
        
    }
    
    mutating func calculatePoints(){

        let difference = (currentRGB.difference(target: targetRGB) * 100)
        var points = Int(100 - difference)

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
