//
//  Sandwich+CoreDataProperties.swift
//  SandwichSaturation
//
//  Created by Emilio Rodriguez on 7/20/20.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//
//

import Foundation
import CoreData


extension Sandwich {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Sandwich> {
        return NSFetchRequest<Sandwich>(entityName: "Sandwich")
    }

    @NSManaged public var name: String
    @NSManaged public var imageName: String
    @NSManaged public var sauceAmount: NSSet

}

// MARK: Generated accessors for sauceAmount
extension Sandwich {

    @objc(addSauceAmountObject:)
    @NSManaged public func addToSauceAmount(_ value: SauceAmountModel)

    @objc(removeSauceAmountObject:)
    @NSManaged public func removeFromSauceAmount(_ value: SauceAmountModel)

    @objc(addSauceAmount:)
    @NSManaged public func addToSauceAmount(_ values: NSSet)

    @objc(removeSauceAmount:)
    @NSManaged public func removeFromSauceAmount(_ values: NSSet)

}
