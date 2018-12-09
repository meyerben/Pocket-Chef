//
//  HomeViewController.swift
//  Pocket Chef
//
//  Created by Jaylin Phipps on 11/13/18.
//  Copyright © 2018 Ryan Rottmann. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    @IBOutlet weak var quickBitesCollectionView: UICollectionView!
    
    @IBOutlet weak var beefRecipesCollectionView: UICollectionView!
    
    @IBOutlet weak var porkRecipesCollectionView: UICollectionView!
    
    
    
    var initalSearchText = ""
    
    var searchController: UISearchController!
    
    var chickenRecipes: [Recipe]?
    var beefRecipes: [Recipe]?
    var porkRecipes: [Recipe]?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //quickBitesCollectionView.
        // Do any additional setup after loading the view.
        quickBitesCollectionView.showsHorizontalScrollIndicator = false
        beefRecipesCollectionView.showsHorizontalScrollIndicator = false
        porkRecipesCollectionView.showsHorizontalScrollIndicator = false
        
        self.quickBitesCollectionView.reloadData()
        
        //Call the YUMMLY API HERE
        YummlyAPI.search(searchText: "Chicken", userInfo: nil, dispatchQueueForHandler: DispatchQueue.main) { (userInfo, recipes, errorString) in
                if errorString != nil{
                    self.chickenRecipes = nil
                } else {
                    self.chickenRecipes = recipes
                }
            self.quickBitesCollectionView.reloadData()
            }
        
        YummlyAPI.search(searchText: "Beef", userInfo: nil, dispatchQueueForHandler: DispatchQueue.main) { (userInfo, recipes, errorString) in
            if errorString != nil{
                self.beefRecipes = nil
            } else {
                self.beefRecipes = recipes
            }
            self.beefRecipesCollectionView.reloadData()
        }
        
        YummlyAPI.search(searchText: "Pork", userInfo: nil, dispatchQueueForHandler: DispatchQueue.main) { (userInfo, recipes, errorString) in
            if errorString != nil{
                self.porkRecipes = nil
            } else {
                self.porkRecipes = recipes
            }
            self.porkRecipesCollectionView.reloadData()
        }
        
    }
    
    //Quick Bites Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.quickBitesCollectionView{
            let chickenCell = collectionView.dequeueReusableCell(withReuseIdentifier: "chickenCell", for: indexPath) as! QuickBitesCollectionViewCell
        
            if let imageUrl = URL(string: chickenRecipes?[indexPath.row].media.srcUrlString ?? "https://www.google.com/url?sa=i&source=images&cd=&ved=2ahUKEwiLypSZ2oLfAhWno4MKHTubAqgQjRx6BAgBEAU&url=https%3A%2F%2Fwww.digitalcitizen.life%2Fset-windows-live-photo-gallery-2011-default-image-viewer&psig=AOvVaw24LBSQ6wWK475KxaeY3eyI&ust=1543893636425251"),
            let imageData = try? Data(contentsOf: imageUrl){
            chickenCell.mealImg.image = UIImage(data: imageData)
            }
        
//        quickBiteCell.mealName.text = quickBitesArray[indexPath.row]
            chickenCell.mealName.text = chickenRecipes?[indexPath.row].recipeName as? String
        
            return chickenCell
            
        }
        else if collectionView == self.beefRecipesCollectionView{
            let beefCell = collectionView.dequeueReusableCell(withReuseIdentifier: "beefCell", for: indexPath) as! BeefRecipesCollectionViewCell

            if let imageUrl = URL(string: beefRecipes?[indexPath.row].media.srcUrlString ?? "https://www.google.com/url?sa=i&source=images&cd=&ved=2ahUKEwiLypSZ2oLfAhWno4MKHTubAqgQjRx6BAgBEAU&url=https%3A%2F%2Fwww.digitalcitizen.life%2Fset-windows-live-photo-gallery-2011-default-image-viewer&psig=AOvVaw24LBSQ6wWK475KxaeY3eyI&ust=1543893636425251"),
                let imageData = try? Data(contentsOf: imageUrl){
                beefCell.recipeImg.image = UIImage(data: imageData)
            }

            //        quickBiteCell.mealName.text = quickBitesArray[indexPath.row]
            beefCell.recipeName.text = beefRecipes?[indexPath.row].recipeName as? String

            return beefCell

        } else if collectionView == self.porkRecipesCollectionView{
            let porkCell = collectionView.dequeueReusableCell(withReuseIdentifier: "porkCell", for: indexPath) as! PorkRecipesCollectionViewCell

            if let imageUrl = URL(string: porkRecipes?[indexPath.row].media.srcUrlString ?? "https://www.google.com/url?sa=i&source=images&cd=&ved=2ahUKEwiLypSZ2oLfAhWno4MKHTubAqgQjRx6BAgBEAU&url=https%3A%2F%2Fwww.digitalcitizen.life%2Fset-windows-live-photo-gallery-2011-default-image-viewer&psig=AOvVaw24LBSQ6wWK475KxaeY3eyI&ust=1543893636425251"),
                let imageData = try? Data(contentsOf: imageUrl){
                porkCell.recipeImg.image = UIImage(data: imageData)
            }

            //        quickBiteCell.mealName.text = quickBitesArray[indexPath.row]
            porkCell.recipeName.text = porkRecipes?[indexPath.row].recipeName as? String

            return porkCell

        } else{
            return UICollectionViewCell()
        }
    }
    
    //Figure out how to show all based on button click so weather its chicken or beef they want to search for
    
    @IBAction func seeAllChicken(_ sender: Any) {
        if initalSearchText == ""{
            initalSearchText = "Chicken"
        }
    }
    
    @IBAction func seeAllBeef(_ sender: Any) {
        if initalSearchText == ""{
            initalSearchText = "Beef"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let seeAll = segue.destination as! QuickBitesSeeAllViewController
        seeAll.initialSearchText = self.initalSearchText
    }
    
}
