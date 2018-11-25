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
    
    static let baseUrlString = "http://api.yummly.com/v1/api/recipes?_app_id=app-id&_app_key="
    static let apiKey = "41ceb77eea15ac39dcb1a1f2f2aaf317"
    
    static let allowedCharacterSet = (CharacterSet(charactersIn: "!*'();:@&=+$,/?%#[] ").inverted)
    
    class func search(searchText: String, userInfo: Any?, dispatchQueueForHandler: DispatchQueue, completionHandler: @escaping (Any?, [Recipe]?, String?) -> Void) {
        
        guard let escapedSearchText = searchText.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) else {
            dispatchQueueForHandler.async(execute: {
                completionHandler(userInfo, nil, "Problem Preparing Search Text")
            })
            return
        }
        
        let urlString = baseUrlString + apiKey + "&" + escapedSearchText
        
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
        
        
        
    }
    
    
}
