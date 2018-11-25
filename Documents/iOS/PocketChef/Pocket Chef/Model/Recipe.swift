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
    var type: String
    var srcUrlString: String
    var width: Int
    var height: Int
}

struct Recipe {
    var recipeName: String
    var cookTime: String
    var ingredients: String
//    var displayTitle: String
//    var mpaaRating: String
//    var criticsPick: Int
//    var byline: String
//    var headline: String
//    var shortSummary: String
//    var publicationDate: Date
//    var openingDate: Date
//    var dateUpdated: Date
    var link: Link
    var media: Media
}


