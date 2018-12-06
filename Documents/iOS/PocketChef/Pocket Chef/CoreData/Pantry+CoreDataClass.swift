//
//  Pantry+CoreDataClass.swift
//  Pocket Chef
//
//  Created by Jaylin Phipps on 12/6/18.
//  Copyright © 2018 Ryan Rottmann. All rights reserved.
//
//

import UIKit
import CoreData

@objc(Pantry)
public class Pantry: NSManagedObject {
    convenience init?(ingredient: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        let context = appDelegate.persistentContainer.viewContext
        self.init(entity: Pantry.entity(), insertInto: context)
        self.foodItem = ingredient
    }
}
