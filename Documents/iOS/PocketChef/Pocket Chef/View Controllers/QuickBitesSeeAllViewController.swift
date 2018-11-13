//
//  QuickBitesSeeAllViewController.swift
//  Pocket Chef
//
//  Created by Jaylin Phipps on 11/13/18.
//  Copyright © 2018 Ryan Rottmann. All rights reserved.
//

import UIKit

class QuickBitesSeeAllViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var quickBitesSeeAllTblView: UITableView!
    
    var quickBitesAllArray = ["Food1","Food2","Food3","Food4","Food5","Food6","Food7","Food8","Food9","Food10",]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quickBitesAllArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let quickBitesSeeAllCell = tableView.dequeueReusableCell(withIdentifier: "quickBitesSeeAllCell", for: indexPath) as! QuickBitesSeeAllTableViewCell
        
        quickBitesSeeAllCell.mealName.text = quickBitesAllArray[indexPath.row]
        
        return quickBitesSeeAllCell
    }

}
