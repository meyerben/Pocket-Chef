//
//  SearchTableViewCell.swift
//  Pocket Chef
//
//  Created by Jaylin Phipps on 12/9/18.
//  Copyright © 2018 Ryan Rottmann. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var singleIngredientImg: UIImageView!
    
    @IBOutlet weak var singleIngredientCookTimeLbl: UILabel!
    @IBOutlet weak var singleIngredientRatingLbl: UILabel!
    @IBOutlet weak var singleIngredientNameLbl: UILabel!
    @IBOutlet weak var singleIngredientRecipeImg: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
