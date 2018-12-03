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
    
    
    var quickBitesAllArray = ["Food1","Food2","Food3","Food4","Food5","Food6","Food7","Food8","Food9","Food10",]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        
        quickBitesSeeAllCell.mealName.text = recipes?[indexPath.row].recipeName as? String
        quickBitesSeeAllCell.mealCookTime.text = recipes?[indexPath.row].cookTime as? String
        
        
        return quickBitesSeeAllCell
    }

}
