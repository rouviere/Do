//  ViewController.swift
//  Do
//
//  Created by Forrest M Anderson on 5/3/18.
//  Copyright © 2018 Rouviere Media. All rights reserved.

import UIKit

class DoViewController: UITableViewController {
  
  var itemArray = [Item]()
  
  // Create a new plist document named Items to hold the data from our app.
  let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

  override func viewDidLoad() {
    super.viewDidLoad()
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
      // What will happen once the user clickc the Add Item button on our UIAlert?
      
      let newItem = Item()
      newItem.title = textField.text!
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
    // Save changes using Encoder
    let encoder = PropertyListEncoder()
    
    do {
      let data = try encoder.encode(itemArray)
      try data.write(to: dataFilePath!)
    } catch {
      print("Error encoding item array, \(error)")
    }
    self.tableView.reloadData()
  }
  
  func loadItems() {
    if let data = try? Data(contentsOf: dataFilePath!) {
      let decoder = PropertyListDecoder()
      do {
        itemArray = try decoder.decode([Item].self, from: data)
      } catch {
        print("Error decoding item array, \(error)")
      }
    }
  }
}
