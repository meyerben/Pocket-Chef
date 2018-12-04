//
//  YummlyAPI.swift
//  Pocket Chef
//
//  Created by Jaylin Phipps on 11/15/18.
//  Copyright © 2018 Ryan Rottmann. All rights reserved.
//

import Foundation


class YummlyAPI {
    
    //http://api.yummly.com/v1/api/recipes?_app_id=d757866f&_app_key=41ceb77eea15ac39dcb1a1f2f2aaf317&your%20_search_parameters
    
    static let baseUrlString = "https://api.yummly.com/v1/api/recipes?_app_id=d757866f&_app_key="
    static let apiKey = "41ceb77eea15ac39dcb1a1f2f2aaf317"
    
    static let allowedCharacterSet = (CharacterSet(charactersIn: "!*'();:@&=+$,/?%#[] ").inverted)
    
    class func search(searchText: String, userInfo: Any?, dispatchQueueForHandler: DispatchQueue, completionHandler: @escaping (Any?, [Recipe]?, String?) -> Void) {
        
        guard let escapedSearchText = searchText.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) else {
            dispatchQueueForHandler.async(execute: {
                completionHandler(userInfo, nil, "Problem Preparing Search Text")
            })
            return
        }
        
        let urlString = baseUrlString + apiKey + "&q=" + escapedSearchText
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        guard let url = URL(string: urlString) else {
            dispatchQueueForHandler.async(execute: {
                completionHandler(userInfo, nil, "The Url for searching is invalid")
            })
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        let task = session.dataTask(with: urlRequest){
            (data, response, error) in
            
            guard error == nil, let data = data else {
                var errorString = "data not available from search"
                if let error = error {
                    errorString = error.localizedDescription
                }
                dispatchQueueForHandler.async(execute: {
                    completionHandler(userInfo, nil, errorString)
                })
                return
            }
            
            let (recipes, errorString) = parse(with: data)
            if let errorString = errorString{
                dispatchQueueForHandler.async(execute: {
                    completionHandler(userInfo, nil, errorString)
                })
            } else {
                dispatchQueueForHandler.async(execute: {
                    completionHandler(userInfo, recipes, nil)
                    })
            }
        }
        task.resume()
    }
    
    
    class func parse(with data: Data) -> ([Recipe]?, String?){
        
    
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []),
            let rootNode = json as? [String:Any] else {
                 //print("Whats Good")
                return (nil, "unable to parse response from yummly server")
        }
        
        //print("\(rootNode)")
        var recipes = [Recipe]()
        print("RESULTS PRINTED HERE")
        
        if let results = rootNode["matches"] as? [[String: Any]]{
            print(rootNode)
            //Need to append the id of the recipe to this URL https://www.yummly.com/recipe/&RECIPE-ID this will give the instructions and cals
            for matches in results{
                    if let id = matches["id"] as? String,
                            //let ingredients = result["ingredients"] as? String,
                            let cookTime = matches["totalTimeInSeconds"] as? Int,
                                let recipeTitle = matches["recipeName"] as? String,
                                let recipeRating = matches["rating"] as? Int,
                                let imageUrlBySizeNode = matches["imageUrlsBySize"] as? [String:String],
                                let recipeImg = imageUrlBySizeNode["90"]{
                                let updatedCookTime = cookTime/60
                                let cookTimeWithMin = "\(updatedCookTime) min"
                                let recipeRatingWithText = "\(recipeRating) Stars"
                                let media = Media(srcUrlString: recipeImg)
                                let recipe = Recipe(recipeName: recipeTitle, cookTime: cookTimeWithMin, recipeRating: recipeRatingWithText, id: id, media: media)

                                recipes.append(recipe)
                                //print(id)
                                //print(ingredients)
                                //print(cookTime)
                                //print(recipeTitle)
                            }
                        }
                    }
             return(recipes, nil)
            }
    }



