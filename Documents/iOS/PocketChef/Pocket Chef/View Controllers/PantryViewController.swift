//
//  PantryViewController.swift
//  Pocket Chef
//
//  Created by Jaylin Phipps on 11/15/18.
//  Copyright © 2018 Ryan Rottmann. All rights reserved.
//

import UIKit

class PantryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var pantryTblView: UITableView!
    
    var pantryArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addPantryItemBtn(_ sender: Any) {
        //Bring up alert with text field
        //Append to array
        //NEED TO STORE ARRAY IN CORE DATA
        let pantryAlert = UIAlertController(title: "Add Item", message: "Enter the item you would like to add to your pantry.", preferredStyle: .alert)

        //Check to make sure its not empty
        pantryAlert.addTextField { (textField) in
            textField.text = ""
        }

        pantryAlert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (_) in
            let textField = pantryAlert.textFields![0]

            self.pantryArray.append(textField.text!)
            self.pantryTblView.reloadData()
        }))

        self.present(pantryAlert, animated: true, completion: nil)
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pantryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pantryItemCell = tableView.dequeueReusableCell(withIdentifier: "pantryItemCell", for: indexPath) as! PantryItemTableViewCell
        
        pantryItemCell.pantryItemLbl.text = pantryArray[indexPath.row]
        
        return pantryItemCell
    }
    
    
}
