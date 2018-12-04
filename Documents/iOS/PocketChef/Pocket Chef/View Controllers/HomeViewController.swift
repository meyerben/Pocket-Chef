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
    
    let initalSearchText = "chicken"
    
    var searchController: UISearchController!
    
    var top5Recipes: [Recipe]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //quickBitesCollectionView.
        // Do any additional setup after loading the view.
        quickBitesCollectionView.showsHorizontalScrollIndicator = false
        
        self.quickBitesCollectionView.reloadData()
    }
    
    //Quick Bites Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return top5Recipes?.count ?? 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let quickBiteCell = collectionView.dequeueReusableCell(withReuseIdentifier: "quickBiteCell", for: indexPath) as! QuickBitesCollectionViewCell
        
        if let imageUrl = URL(string: top5Recipes?[indexPath.row].media.srcUrlString ?? "https://www.google.com/url?sa=i&source=images&cd=&ved=2ahUKEwiLypSZ2oLfAhWno4MKHTubAqgQjRx6BAgBEAU&url=https%3A%2F%2Fwww.digitalcitizen.life%2Fset-windows-live-photo-gallery-2011-default-image-viewer&psig=AOvVaw24LBSQ6wWK475KxaeY3eyI&ust=1543893636425251"),
            let imageData = try? Data(contentsOf: imageUrl){
            quickBiteCell.mealImg.image = UIImage(data: imageData)
        }
        
//        quickBiteCell.mealName.text = quickBitesArray[indexPath.row]
        quickBiteCell.mealName.text = top5Recipes?[indexPath.row].recipeName as? String
        
        return quickBiteCell
    }

}
