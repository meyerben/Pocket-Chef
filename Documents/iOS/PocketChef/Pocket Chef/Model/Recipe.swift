//
//  Recipe.swift
//  Pocket Chef
//
//  Created by Jaylin Phipps on 11/15/18.
//  Copyright © 2018 Ryan Rottmann. All rights reserved.
//

import Foundation

struct Link {
    var type: String
    var urlString: String
    var linkText: String
}

struct Media {
    var srcUrlString: String
}

struct Recipe {
    var recipeName: Any
    var cookTime: String
    var recipeRating: String
    var recipeURL: String
    //var recipeIngredients: Any
    //var category: String
    var id: Any
    var media: Media
}


