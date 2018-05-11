//  ViewController.swift
//  Do
//
//  Created by Forrest M Anderson on 5/3/18.
//  Copyright © 2018 Rouviere Media. All rights reserved.

import UIKit
import RealmSwift

class ToDoListViewController: UITableViewController {
  
  var toDoItems: Results<Item>?
  let realm = try! Realm()
  
    var selectedCategory: Category? {
      didSet {
        loadItems()
      }
    }

  override func viewDidLoad() {
    super.viewDidLoad()
   
  }
  
  //MARK - TableView Datasource Methods
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return toDoItems?.count ?? 1
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "DoItemCell", for: indexPath)
    
    if let item = toDoItems?[indexPath.row] {
      cell.textLabel?.text = item.title
      cell.accessoryType = item.done ? .checkmark : .none
    } else {
      cell.textLabel?.text = "No Items Added yet"
    }
    
    return cell
  }
  
  //MARK - TableView Delegate Methods
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    if let item = toDoItems?[indexPath.row] {
      
      do {
      try realm.write {
          item.done = !item.done
          // realm.delete(item) // deletes an item when you tap on it.
      }
      } catch {
        print("Error saving done status, \(error)")
      }
    }
    
    tableView.reloadData()
    
    tableView.deselectRow(at: indexPath, animated: true)
   }
  
  //MARK - Add New Items
  @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    var textField = UITextField()
    
    let alert = UIAlertController(title: "Add New Task", message: "", preferredStyle: .alert)
    
    let action = UIAlertAction(title: "Add Item", style: .default) { (action) in

      if let currentCategory = self.selectedCategory {
        do {
        try self.realm.write {
          let newItem = Item()
          newItem.title = textField.text!
          newItem.dateCreated = Date()
          currentCategory.items.append(newItem)
          }
          }catch {
            print("Error saving new item \(error)")
        }
      }
      self.tableView.reloadData()
    }
    
    alert.addTextField { (alertTextField) in
      alertTextField.placeholder = "Create new item"
      textField = alertTextField
    }
    
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
  }
  
  //MARK - Model Manipulation Methods
  func loadItems() {

    toDoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
    
    tableView.reloadData()
  }
} // End Class


extension ToDoListViewController: UISearchBarDelegate {

  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    
    toDoItems = toDoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
    
    tableView.reloadData()
  }

  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if searchBar.text?.count == 0 {
      loadItems()

      DispatchQueue.main.async {
        searchBar.resignFirstResponder()
      }
    }
  }
}

