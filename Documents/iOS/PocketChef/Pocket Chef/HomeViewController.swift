//
//  HomeViewController.swift
//  Pocket Chef
//
//  Created by Ryan Rottmann on 11/1/18.
//  Copyright © 2018 Ryan Rottmann. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var quickBitesCollectionView: UICollectionView!
    
    let quickBites = ["Meal 1","Meal 2","Meal 3","Meal 4","Meal 5"]
    let quickBitesImg = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return quickBites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let quickBiteCell = collectionView.dequeueReusableCell(withReuseIdentifier: "quickBitesCell", for: indexPath) as! QuickBitesCollectionViewCell
        
        //quickBiteCell.quickBiteImg.image = quickBitesImg[indexPath.row]
        quickBiteCell.quickBiteLbl.text = quickBites[indexPath.row]
        
        return quickBiteCell
    }
    

}
