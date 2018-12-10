//
//  FavoriteRecipeViewController.swift
//  Pocket Chef
//
//  Created by Jaylin Phipps on 12/9/18.
//  Copyright © 2018 Ryan Rottmann. All rights reserved.
//

import UIKit
import CoreData

class FavoriteRecipeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var favRecipeName: String = ""
    var favRecipeUrl: String  = ""
    
    @IBOutlet weak var favRecipeTblView: UITableView!
    var favArray = [Favorites]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        favRecipeTblView.tableFooterView = UIView()
        // Do any additional setup after loading the view.
        //print(favRecipeName)
        //print(favRecipeUrl)
        let savedForLaterLogo = UIImage(named: "SavedforLater.png")
        let imageView = UIImageView(image: savedForLaterLogo)
        self.navigationItem.titleView = imageView
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
            
        }
        let context = appDelegate.persistentContainer.viewContext
        let request: NSFetchRequest<Favorites> = Favorites.fetchRequest()
        
        do{
            favArray = try context.fetch(request)
            favRecipeTblView.reloadData()
        } catch {
            print("Failed to get pantry items")
        }
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func visitRecipeBtn(_ sender: Any) {
//        let favRecipeWebKit = segue.destination as! WebKitViewController
//
//        favRecipeWebKit.recipeURL = favRecipeUrl
//        print(favRecipeUrl)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let favCell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath)
        
        if let favCell = favCell as? FavoriteRecipeTableViewCell{
            favCell.recipeName.text = favArray[indexPath.row].favRecipeName
            favRecipeUrl = favArray[indexPath.row].favRecipeURL!
        }
        return favCell
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete", handler: {action, view, completion in
            let favRecipe = self.favArray[indexPath.row]
            do{
                favRecipe.managedObjectContext?.delete(favRecipe)
                try favRecipe.managedObjectContext?.save()
                self.favArray.remove(at: indexPath.row)
                self.favRecipeTblView.deleteRows(at: [indexPath], with: .automatic)
                completion(true)
            } catch {
                print("Failed to delete")
                completion(false)
            }
        })
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let favRecipeWebKit = segue.destination as! WebKitViewController
        favRecipeWebKit.recipeURL = favRecipeUrl
            
    }
}
