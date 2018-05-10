//  ViewController.swift
//  Do
//
//  Created by Forrest M Anderson on 5/3/18.
//  Copyright © 2018 Rouviere Media. All rights reserved.

import UIKit
import CoreData

class ToDoListViewController: UITableViewController {
  
  var itemArray = [Item]()
  
  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

  override func viewDidLoad() {
    super.viewDidLoad()
    
     print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    loadItems()
  }
  
  //MARK - TableView Datasource Methods
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return itemArray.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "DoItemCell", for: indexPath)
    
    let item = itemArray[indexPath.row]
    cell.textLabel?.text = itemArray[indexPath.row].title
    cell.accessoryType = item.done ? .checkmark : .none
    
    return cell
  }
  
  //MARK - TableView Delegate Methods
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
   // print(itemArray[indexPath.row]) // prints the title of each row.
    
   itemArray[indexPath.row].done = !itemArray[indexPath.row].done
    
    saveItems()
    
    tableView.deselectRow(at: indexPath, animated: true)  // removes the hightlight from the row that is tapped
   }
  
  //MARK - Add New Items
  @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    var textField = UITextField() // empty var to be used below
    
    let alert = UIAlertController(title: "Add New Task", message: "", preferredStyle: .alert)
    
    let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
      // What will happen once the user clicks the Add Item button on our UIAlert?
      
      let newItem = Item(context: self.context)
      newItem.title = textField.text!
      newItem.done = false
     // newItem.parentCategory = self.selectedCategory
      self.itemArray.append(newItem)
      
      self.saveItems()
    }
    
    alert.addTextField { (alertTextField) in
      alertTextField.placeholder = "Create new item"
      textField = alertTextField
    }
    
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
  }
  
  //MARK - Model Manipulation Methods
  func saveItems() {
  
    do {
      try context.save()
    } catch {
      print("Error saving context \(error)")
    }
    self.tableView.reloadData()
  }
  

  
  func loadItems() {
    let request: NSFetchRequest<Item> = Item.fetchRequest()
  
    do {
      itemArray = try context.fetch(request)
    } catch {
      print("Error fetching data from context \(error)")
    }
    self.tableView.reloadData()
  }
} // End Class


