//
//  CategoryViewController.swift
//  Do
//
//  Created by Forrest M Anderson on 5/9/18.
//  Copyright © 2018 Rouviere Media. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
  
    // 1
    var categories = [Category]()
  
    // 2
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
      
      // 17
     loadCategories()
    }
  
  //MARK: - TableView DataSource Methods
  
  // 3
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return categories.count
  }
  
  // 4
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    // 5
    let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
    
    // 6
    cell.textLabel?.text = categories[indexPath.row].name
    
    // 7
    return cell
  }
  
  
  //MARK - TableView Delegate Methods
  
  // 18
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    // 19
    performSegue(withIdentifier: "goToItems", sender: self)
    
  }
  
  // 20
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let destinationVC = segue.destination as! ToDoListViewController
    
    if let indexPath = tableView.indexPathForSelectedRow {
      destinationVC.selectedCategory = categories[indexPath.row]
    }
  }
  
  
  
  //MARK: - Add New Categories
  
  // 8
  @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    
    // 13
    var textField = UITextField() // empty var to be used below
    
    // 9
    let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
    
    // 10
    let action = UIAlertAction(title: "Add", style: .default) { (action) in
      // What will happen once the user clicks the Add button on our UIAlert?
      
      // 14
      let newCategory = Category(context: self.context)
      newCategory.name = textField.text!
      self.categories.append(newCategory)
      self.saveCategories() // see 15
    }
    
    // 11
    alert.addAction(action)
    
    // 12
    alert.addTextField { (field) in
      textField = field
      textField.placeholder = "Add a new category"
    }
    
    present(alert, animated: true, completion: nil)
    
  }
  
  //MARK: - Data Manipulation Methods
  
  // 15
  func saveCategories() {
    
    do {
      try context.save()
    } catch {
      print("Error saving category \(error)")
    }
    tableView.reloadData()
  }
  
  // 16
  func loadCategories() {
    
    let request: NSFetchRequest<Category> = Category.fetchRequest()
    
    do {
      categories = try context.fetch(request)
    } catch {
      print("Error fetching data from context \(error)")
    }
    tableView.reloadData()
  }
}
