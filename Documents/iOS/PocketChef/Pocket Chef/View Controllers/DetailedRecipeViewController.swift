//
//  DetailedRecipeViewController.swift
//  Pocket Chef
//
//  Created by Jaylin Phipps on 12/4/18.
//  Copyright © 2018 Ryan Rottmann. All rights reserved.
//

import UIKit

class DetailedRecipeViewController: UIViewController {

    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeRating: UILabel!
    @IBOutlet weak var recipeCookTIme: UILabel!
    @IBOutlet weak var recipeImg: UIImageView!
    
    
    var recipeN: String = ""
    var recipeCategory: String = ""
    var recipeRate: String = ""
    var recipeTime: String = ""
    var recipeLink: String = ""
    var recipeImgUrl: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        recipeName.text = recipeN
        recipeRating.text = recipeRate
        recipeCookTIme.text = recipeTime
        
        if let imageUrl = URL(string: recipeImgUrl),
            let imageData = try? Data(contentsOf: imageUrl){
            recipeImg.image = UIImage(data: imageData)
        }
    }
    
    @IBAction func visitRecipe(_ sender: Any) {
        print("\(recipeLink)")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let recipeWebKit = segue.destination as! WebKitViewController
        
        recipeWebKit.recipeURL = recipeLink
        
    }
}
