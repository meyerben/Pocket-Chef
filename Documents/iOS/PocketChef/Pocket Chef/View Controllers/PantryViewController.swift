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

    @IBOutlet weak var ingredientTxt: UITextField!
    @IBOutlet weak var pantryTblView: UITableView!
    
    @IBOutlet weak var pantrySearchBtn: UIButton!
    
    var foodPantry: Pantry?
    var pantryArray = [Pantry]()
    var currentIndex = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pantryTblView.tableFooterView = UIView()
        
        let pantryLogo = UIImage(named: "Pantry.png")
        let imageView = UIImageView(image: pantryLogo)
        self.navigationItem.titleView = imageView
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
            
        }
        let context = appDelegate.persistentContainer.viewContext
        let request: NSFetchRequest<Pantry> = Pantry.fetchRequest()
        
        do{
            pantryArray = try context.fetch(request)
            pantryTblView.reloadData()
        } catch {
            print("Failed to get pantry items")
        }
    }
    
    @IBAction func addPantryItemBtn(_ sender: Any) {
        pantryTblView.reloadData()
        
        if ingredientTxt.text == ""{
            print("Error")
            return
        }
        
        guard let itemName = ingredientTxt.text else {
            return
        }
        var pantry: Pantry?
        pantry = Pantry(ingredient: itemName)
        
        do{
            try pantry?.managedObjectContext?.save()
            pantryTblView.reloadData()
        } catch {
            print("Failed to save")
        }
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
            
        }
        let context = appDelegate.persistentContainer.viewContext
        let request: NSFetchRequest<Pantry> = Pantry.fetchRequest()
        
        do{
            pantryArray = try context.fetch(request)
            pantryTblView.reloadData()
        } catch {
            print("Failed to get pantry items")
        }
        
        ingredientTxt.text = ""
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pantryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pantryItemCell = tableView.dequeueReusableCell(withIdentifier: "pantryItemCell", for: indexPath) as! PantryItemTableViewCell
        
        pantryItemCell.pantryItemLbl?.text = pantryArray[indexPath.row].foodItem
        return pantryItemCell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete", handler: {action, view, completion in
            let pantry = self.pantryArray[indexPath.row]
            do{
                pantry.managedObjectContext?.delete(pantry)
                try pantry.managedObjectContext?.save()
                self.pantryArray.remove(at: indexPath.row)
                self.pantryTblView.deleteRows(at: [indexPath], with: .automatic)
                completion(true)
            } catch {
                print("Failed to delete")
                completion(false)
            }
        })
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        currentIndex = pantryArray[indexPath.row].foodItem!
        print(currentIndex)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let pantrySearch = segue.destination as! SearchByIngredientViewController
        
        pantrySearch.initalSearch = currentIndex.lowercased()
    }
}
