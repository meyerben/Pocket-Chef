//
//  HomeViewController.swift
//  Pocket Chef
//
//  Created by Jaylin Phipps on 11/13/18.
//  Copyright © 2018 Ryan Rottmann. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var quickBitesCollectionView: UICollectionView!
    
    //Test Data
    var quickBitesArray = ["Food1","Food2","Food3","Food4","Food5","Food6","Food7","Food8","Food9","Food10"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        quickBitesCollectionView.showsHorizontalScrollIndicator = false
    }
    

    //Quick Bites Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let quickBiteCell = collectionView.dequeueReusableCell(withReuseIdentifier: "quickBiteCell", for: indexPath) as! QuickBitesCollectionViewCell
        
        quickBiteCell.mealName.text = quickBitesArray[indexPath.row]
        
        return quickBiteCell
    }

}
