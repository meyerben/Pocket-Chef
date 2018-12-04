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
    var cookTime: Int
    var recipeRating: Int
    //var ingredients: Any
    //var attribution: String
    //var source: String
    var id: Any
//    var displayTitle: String
//    var mpaaRating: String
//    var criticsPick: Int
//    var byline: String
//    var headline: String
//    var shortSummary: String
//    var publicationDate: Date
//    var openingDate: Date
//    var dateUpdated: Date
//    var link: Link
    var media: Media
}


