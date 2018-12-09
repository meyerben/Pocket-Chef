//
//  SearchByIngredientViewController.swift
//  Pocket Chef
//
//  Created by Jaylin Phipps on 12/4/18.
//  Copyright © 2018 Ryan Rottmann. All rights reserved.
//

import UIKit

class SearchByIngredientViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
    @IBOutlet weak var ingredientRecipeTblView: UITableView!
    
    var searchController: UISearchController!
    
    var ingredientRecipes: [Recipe]?
    
    var initalSearch = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ingredientRecipeTblView.tableFooterView = UIView()
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        //searchController.dimsBackgroundDuringPresentation = false
        //searchController.searchBar.sizeToFit()
        searchController.searchBar.text = initalSearch
        //ingredientRecipeTblView.tableHeaderView = searchController.searchBar
        
        self.ingredientRecipeTblView.reloadData()
        
        searchController.isActive = true
        
        print(initalSearch)
        
        if ingredientRecipes == nil{
            print("Error")
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
            YummlySearchByIngredient.search(searchText: initalSearch, userInfo: nil, dispatchQueueForHandler: DispatchQueue.main) { (userInfo, recipes, errorString) in
                if errorString != nil{
                    self.ingredientRecipes = nil
                    //print("Error")
                } else {
                    self.ingredientRecipes = recipes
                }
                self.ingredientRecipeTblView.reloadData()
            }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredientRecipes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ingredientCell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath)
        
        if let ingredientCell = ingredientCell as? SearchByIngredientsTableViewCell{
            
            if let imageUrl = URL(string: ingredientRecipes?[indexPath.row].media.srcUrlString ?? "https://www.google.com/url?sa=i&source=images&cd=&ved=2ahUKEwiLypSZ2oLfAhWno4MKHTubAqgQjRx6BAgBEAU&url=https%3A%2F%2Fwww.digitalcitizen.life%2Fset-windows-live-photo-gallery-2011-default-image-viewer&psig=AOvVaw24LBSQ6wWK475KxaeY3eyI&ust=1543893636425251"),
                let imageData = try? Data(contentsOf: imageUrl){
                ingredientCell.recipeImg.image = UIImage(data: imageData)
            }
            
            ingredientCell.recipeName.text = ingredientRecipes?[indexPath.row].recipeName as? String
            ingredientCell.recipeRating.text = ingredientRecipes?[indexPath.row].recipeRating
            ingredientCell.recipeCookTime.text = ingredientRecipes?[indexPath.row].cookTime
            
        }
        return ingredientCell
    }

    

}
