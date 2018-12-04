//
//  PantryViewController.swift
//  Pocket Chef
//
//  Created by Jaylin Phipps on 11/15/18.
//  Copyright © 2018 Ryan Rottmann. All rights reserved.
//

import UIKit
import CoreData

class PantryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var pantryTblView: UITableView!
    
    var pantryArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Pantry", in: context)
        let newPantyItem = NSManagedObject(entity: entity!, insertInto: context)
        
        newPantyItem.setValue("Bananas", forKey: "foodItem")
        newPantyItem.setValue("Hot Dogs", forKey: "foodItem")
        
        do{
            try context.save()
        } catch {
            print("Failed Saving")
        }
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Pantry")
        request.returnsObjectsAsFaults = false
        
        do{
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject]{
                print(data.value(forKey: "foodItem") as! String)
            }
        } catch {
            print("Failed")
        }
        
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
