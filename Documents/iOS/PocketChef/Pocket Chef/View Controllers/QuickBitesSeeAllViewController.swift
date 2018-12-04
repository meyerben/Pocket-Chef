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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        quickBitesSeeAllTblView.tableFooterView = UIView()
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        quickBitesSeeAllTblView.tableHeaderView = searchController.searchBar
        
        
        let editButtonItem = self.editButtonItem
        self.navigationItem.rightBarButtonItem = editButtonItem
        
        searchController.searchBar.text = initialSearchText
        // Do any additional setup after loading the view.
        self.quickBitesSeeAllTblView.reloadData()
        
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
        
        let quickBitesSeeAllCell = tableView.dequeueReusableCell(withIdentifier: "quickBitesSeeAllCell", for: indexPath) as! QuickBitesSeeAllTableViewCell

        if let imageUrl = URL(string: recipes?[indexPath.row].media.srcUrlString ?? "https://www.google.com/url?sa=i&source=images&cd=&ved=2ahUKEwiLypSZ2oLfAhWno4MKHTubAqgQjRx6BAgBEAU&url=https%3A%2F%2Fwww.digitalcitizen.life%2Fset-windows-live-photo-gallery-2011-default-image-viewer&psig=AOvVaw24LBSQ6wWK475KxaeY3eyI&ust=1543893636425251"),
            let imageData = try? Data(contentsOf: imageUrl) {
            quickBitesSeeAllCell.mealImg.image = UIImage(data: imageData)
        }
        
        quickBitesSeeAllCell.mealName.text = recipes?[indexPath.row].recipeName as? String
        quickBitesSeeAllCell.mealCookTime.text = recipes?[indexPath.row].cookTime as? String
        quickBitesSeeAllCell.mealRating.text = recipes?[indexPath.row].recipeRating as? String
        
        
        
        
        
        return quickBitesSeeAllCell
    }

}
