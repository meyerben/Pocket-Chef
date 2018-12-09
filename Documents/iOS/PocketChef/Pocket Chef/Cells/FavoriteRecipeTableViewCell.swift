//
//  FavoriteRecipeTableViewCell.swift
//  Pocket Chef
//
//  Created by Jaylin Phipps on 12/9/18.
//  Copyright © 2018 Ryan Rottmann. All rights reserved.
//

import UIKit

class FavoriteRecipeTableViewCell: UITableViewCell {

    @IBOutlet weak var recipeName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
