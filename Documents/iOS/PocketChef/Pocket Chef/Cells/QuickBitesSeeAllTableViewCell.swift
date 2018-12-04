//
//  QuickBitesSeeAllTableViewCell.swift
//  Pocket Chef
//
//  Created by Jaylin Phipps on 11/13/18.
//  Copyright © 2018 Ryan Rottmann. All rights reserved.
//

import UIKit

class QuickBitesSeeAllTableViewCell: UITableViewCell {

    @IBOutlet weak var mealCookTime: UILabel!
    @IBOutlet weak var mealCat: UILabel!
    @IBOutlet weak var mealName: UILabel!
    @IBOutlet weak var mealImg: UIImageView!
    @IBOutlet weak var mealRating: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
