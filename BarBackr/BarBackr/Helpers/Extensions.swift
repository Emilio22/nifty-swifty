//
//  Extensions.swift
//  BarBackr
//
//  Created by Emilio Rodriguez on 8/15/20.
//  Copyright © 2020 RWbc Emilio. All rights reserved.
//

import Foundation
import UIKit

//MARK: - Cocktail
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
// MARK:- Table  View
extension UITableView {

    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 24)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }

    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}

// MARK:- File Manager
extension FileManager {
  static var documentDirectoryURL: URL {
    return `default`.urls(for: .documentDirectory, in: .userDomainMask)[0]
  }
}
