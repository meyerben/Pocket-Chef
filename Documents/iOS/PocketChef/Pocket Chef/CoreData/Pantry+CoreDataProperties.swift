//
//  Pantry+CoreDataProperties.swift
//  Pocket Chef
//
//  Created by Jaylin Phipps on 12/3/18.
//  Copyright © 2018 Ryan Rottmann. All rights reserved.
//
//

import Foundation
import CoreData


extension Pantry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pantry> {
        return NSFetchRequest<Pantry>(entityName: "Pantry")
    }

    @NSManaged public var foodItem: String?

}
