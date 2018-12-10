//
//  SearchViewController.swift
//  Pocket Chef
//
//  Created by Jaylin Phipps on 12/9/18.
//  Copyright © 2018 Ryan Rottmann. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var singleIngredientTblView: UITableView!
    
    var searchController: UISearchController!
    
    var ingredientRecipes: [Recipe]?
    
    var favorites: Favorites?
    
    var initalSearch = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        singleIngredientTblView.tableFooterView = UIView()
        
        searchController = UISearchController(searchResultsController: nil)
        //searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        searchController.searchBar.text = initalSearch
        
        singleIngredientTblView.tableHeaderView = searchController.searchBar
        
        self.singleIngredientTblView.reloadData()
        
        searchController.isActive = true
        
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
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let favorite = UITableViewRowAction(style: .normal, title: "Favorite") { (action, indexPath) in
            // share item at indexPath
            print("Working")
            self.favorites = Favorites(favRecipeName: self.ingredientRecipes?[indexPath.row].recipeName as! String, favRecipeURL: self.ingredientRecipes?[indexPath.row].recipeURL ?? "www.yummly.com")
            
            do{
                try self.favorites?.managedObjectContext?.save()
            } catch {
                print("Failed to save")
            }
            //print(self.favorites?.favRecipeName!)
        }
        
        favorite.backgroundColor = UIColor.green
        
        return [favorite]
    }
    
    
    @IBAction func searchSubmit(_ sender: Any) {
        
        initalSearch = searchController.searchBar.text!.lowercased()
        if initalSearch == nil{
            print("Error")
        }
        
        YummlySearchByIngredient.search(searchText: initalSearch, userInfo: nil, dispatchQueueForHandler: DispatchQueue.main) { (userInfo, recipes, errorString) in
            if errorString != nil{
                self.ingredientRecipes = nil
            } else {
                self.ingredientRecipes = recipes
            }
            self.singleIngredientTblView.reloadData()
        }
        searchController.dismiss(animated: true, completion: {})
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = singleIngredientTblView.indexPathForSelectedRow{
            let selectedRow = indexPath.row
            let recipeWebView = segue.destination as! WebKitViewController
            recipeWebView.recipeURL = self.ingredientRecipes?[selectedRow].recipeURL ?? "www.yummly.com"
        }
        searchController.dismiss(animated: true, completion: {})
    }
    
}
