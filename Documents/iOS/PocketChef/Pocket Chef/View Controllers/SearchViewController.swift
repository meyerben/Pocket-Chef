//
//  SearchViewController.swift
//  Pocket Chef
//
//  Created by Jaylin Phipps on 12/9/18.
//  Copyright © 2018 Ryan Rottmann. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
    
    @IBOutlet weak var singleIngredientTblView: UITableView!
    
    var searchController: UISearchController!
    
    var ingredientRecipes: [Recipe]?
    
    var favorites: Favorites?
    
    var initalSearch = "Garlic"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        singleIngredientTblView.tableFooterView = UIView()
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        searchController.searchBar.text = initalSearch
        
        singleIngredientTblView.tableHeaderView = searchController.searchBar
        
        self.singleIngredientTblView.reloadData()
        
        searchController.isActive = true
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        YummlySearchByIngredient.search(searchText: initalSearch.lowercased(), userInfo: nil, dispatchQueueForHandler: DispatchQueue.main) { (userInfo, recipes, errorString) in
            if errorString != nil{
                self.ingredientRecipes = nil
            } else {
                self.ingredientRecipes = recipes
            }
            self.singleIngredientTblView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredientRecipes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ingredientCell = tableView.dequeueReusableCell(withIdentifier: "singleIngredientCell", for: indexPath)
        
        if let ingredientCell = ingredientCell as? SearchTableViewCell{
            if let imageUrl = URL(string: ingredientRecipes?[indexPath.row].media.srcUrlString ?? "https://www.google.com/url?sa=i&source=images&cd=&ved=2ahUKEwiLypSZ2oLfAhWno4MKHTubAqgQjRx6BAgBEAU&url=https%3A%2F%2Fwww.digitalcitizen.life%2Fset-windows-live-photo-gallery-2011-default-image-viewer&psig=AOvVaw24LBSQ6wWK475KxaeY3eyI&ust=1543893636425251"),
                let imageData = try? Data(contentsOf: imageUrl){
                ingredientCell.singleIngredientImg.image = UIImage(data: imageData)
            }
            
            ingredientCell.singleIngredientNameLbl.text = ingredientRecipes?[indexPath.row].recipeName as? String
            ingredientCell.singleIngredientRatingLbl.text = ingredientRecipes?[indexPath.row].recipeRating
            ingredientCell.singleIngredientCookTimeLbl.text = ingredientRecipes?[indexPath.row].cookTime
        }
        return ingredientCell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
