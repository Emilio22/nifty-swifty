//
//  Extensions.swift
//  BarBackr
//
//  Created by Emilio Rodriguez on 8/15/20.
//  Copyright © 2020 RWbc Emilio. All rights reserved.
//

import Foundation
import UIKit


extension Cocktail {
    
    func getIngredients() -> [String] {
        let mirrorCocktail = Mirror(reflecting: self)
        
        var ingredients: [String] = []
        for child in mirrorCocktail.children {
            if let ingredientKey = child.label {
                let ingredientValue = child.value as? String
                if ingredientKey.contains("ingredient") && ingredientValue != nil {
                    ingredients.append(ingredientValue!)
                }
            }
        }
        return ingredients.compactMap{ $0 }
    }
    
    func getMeasurements() -> [String] {
        let mirrorCocktail = Mirror(reflecting: self)
        
        var measurements: [String] = []
        for child in mirrorCocktail.children {
            if let measurementKey = child.label {
                let ingredientValue = child.value as? String
                if measurementKey.contains("measurement") && ingredientValue != nil {
                    measurements.append(ingredientValue!)
                }
            }
        }
        return measurements.compactMap{ $0 }
    }
    
}
