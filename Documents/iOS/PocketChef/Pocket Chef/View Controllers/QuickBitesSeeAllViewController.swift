//
//  QuickBitesSeeAllViewController.swift
//  Pocket Chef
//
//  Created by Jaylin Phipps on 11/13/18.
//  Copyright © 2018 Ryan Rottmann. All rights reserved.
//

import UIKit

class QuickBitesSeeAllViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
    let initialSearchText = "chicken"
    
    var searchController: UISearchController!
    
    @IBOutlet weak var quickBitesSeeAllTblView: UITableView!
    
    var recipes: [Recipe]?
    
    var favorites: Favorites?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        quickBitesSeeAllTblView.tableFooterView = UIView()
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        quickBitesSeeAllTblView.tableHeaderView = searchController.searchBar
        
    
        searchController.searchBar.text = initialSearchText
        // Do any additional setup after loading the view.
        self.quickBitesSeeAllTblView.reloadData()
        
        searchController.isActive = true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text{
            YummlyAPI.search(searchText: searchText, userInfo: nil, dispatchQueueForHandler: DispatchQueue.main) { (userInfo, recipes, errorString) in
                if errorString != nil{
                    self.recipes = nil
                } else {
                    self.recipes = recipes
                }
                self.quickBitesSeeAllTblView.reloadData()
            }
            
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let quickBitesSeeAllCell = tableView.dequeueReusableCell(withIdentifier: "quickBitesSeeAllCell", for: indexPath)
        
        if let quickBitesSeeAllCell = quickBitesSeeAllCell as? QuickBitesSeeAllTableViewCell{

        if let imageUrl = URL(string: recipes?[indexPath.row].media.srcUrlString ?? "https://www.google.com/url?sa=i&source=images&cd=&ved=2ahUKEwiLypSZ2oLfAhWno4MKHTubAqgQjRx6BAgBEAU&url=https%3A%2F%2Fwww.digitalcitizen.life%2Fset-windows-live-photo-gallery-2011-default-image-viewer&psig=AOvVaw24LBSQ6wWK475KxaeY3eyI&ust=1543893636425251"),
            let imageData = try? Data(contentsOf: imageUrl) {
            quickBitesSeeAllCell.mealImg.image = UIImage(data: imageData)
        }
        
        quickBitesSeeAllCell.mealName.text = recipes?[indexPath.row].recipeName as? String
        quickBitesSeeAllCell.mealCookTime.text = recipes?[indexPath.row].cookTime
        quickBitesSeeAllCell.mealRating.text = recipes?[indexPath.row].recipeRating
        
        }
        return quickBitesSeeAllCell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let favorite = UITableViewRowAction(style: .normal, title: "Favorite") { (action, indexPath) in
            // share item at indexPath
            
            self.favorites = Favorites(favRecipeName: self.recipes?[indexPath.row].recipeName as! String, favRecipeURL: self.recipes?[indexPath.row].recipeURL ?? "www.yummly.com")
            
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let indexPath = quickBitesSeeAllTblView.indexPathForSelectedRow{
            let selectedRow = indexPath.row
            let detailedRecipe = segue.destination as! DetailedRecipeViewController
            //detailVC.park = self.parksArray[selectedRow]
            detailedRecipe.recipeN = self.recipes?[selectedRow].recipeName as! String
            detailedRecipe.recipeTime = self.recipes?[selectedRow].cookTime ?? "No Cook Time Found"
            detailedRecipe.recipeRate = self.recipes?[selectedRow].recipeRating ?? "No Rating Found"
//            detailedRecipe.recipeCategory = self.recipes?[selectedRow].category ?? "No Category Found"
//            detailedRecipe.recipeName.text = self.recipes?[selectedRow].recipeName as? String
            detailedRecipe.recipeLink = self.recipes?[selectedRow].recipeURL ?? "No URL Found"
            detailedRecipe.recipeImgUrl = self.recipes?[indexPath.row].media.srcUrlString ?? "https://www.google.com/url?sa=i&source=images&cd=&ved=2ahUKEwiLypSZ2oLfAhWno4MKHTubAqgQjRx6BAgBEAU&url=https%3A%2F%2Fwww.digitalcitizen.life%2Fset-windows-live-photo-gallery-2011-default-image-viewer&psig=AOvVaw24LBSQ6wWK475KxaeY3eyI&ust=1543893636425251"
        }
        searchController.dismiss(animated: true, completion: {})
    }

}
