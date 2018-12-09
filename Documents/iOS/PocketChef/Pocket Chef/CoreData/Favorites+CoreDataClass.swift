//
//  Favorites+CoreDataClass.swift
//  Pocket Chef
//
//  Created by Jaylin Phipps on 12/9/18.
//  Copyright © 2018 Ryan Rottmann. All rights reserved.
//
//

import UIKit
import CoreData

@objc(Favorites)
public class Favorites: NSManagedObject {

    convenience init?(favRecipeName: String, favRecipeURL: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        let context = appDelegate.persistentContainer.viewContext
        self.init(entity: Favorites.entity(), insertInto: context)
        self.favRecipeName = favRecipeName
        self.favRecipeURL = favRecipeURL
    }
}
