//
//  ViewController.swift
//  Do
//
//  Created by Forrest M Anderson on 5/3/18.
//  Copyright © 2018 Rouviere Media. All rights reserved.
//

import UIKit

class DoViewController: UITableViewController {
  
  var itemArray = ["Learn Swift", "Find a good job", "Pay off debt"]
  
  let defaults = UserDefaults.standard  // an interface to the user defaults database where you store key value pairs consistently across launches of the app

  override func viewDidLoad() {
    super.viewDidLoad()
    
    // To use the data that is stored in NSUserDefaults you:
    if let items = defaults.array(forKey: "DoListArray") as? [String] {
      itemArray = items
    }
  }
  
  //MARK - TableView Datasource Methods
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return itemArray.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "DoItemCell", for: indexPath)
    cell.textLabel?.text = itemArray[indexPath.row]
    
    return cell
  }
  
  //MARK - TableView Delegate Methods
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print(itemArray[indexPath.row]) // prints the title of each row.
    if let cell = tableView.cellForRow(at: indexPath) {
      if cell.accessoryType == .none {
        cell.accessoryType = .checkmark
      } else {
        cell.accessoryType = .none
      }
      tableView.deselectRow(at: indexPath, animated: true)  // removes the hightlight from the row that is tapped
    }
  }
  
  
  
  //MARK - Add New Items
  @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    
    var textField = UITextField() // empty var to be used below
    
    let alert = UIAlertController(title: "Add New Task", message: "", preferredStyle: .alert)
    let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
      // What will happen once the user clickc the Add Item button on our UIAlert?
      
      self.itemArray.append(textField.text!)
      
      // To save changes to UserDefaults
      self.defaults.set(self.itemArray, forKey: "DoListArray")
      
      self.tableView.reloadData()
    }
    
    alert.addTextField { (alertTextField) in
      alertTextField.placeholder = "Create new item"
      textField = alertTextField
    }
    
    alert.addAction(action)
    
    present(alert, animated: true, completion: nil)
  }
}

