//
//  Category.swift
//  Do
//
//  Created by Forrest M Anderson on 5/11/18.
//  Copyright © 2018 Rouviere Media. All rights reserved.
//

import Foundation

import Foundation
import RealmSwift

class Category: Object {
  @objc dynamic var name: String = ""
  
  // Set up the relationship between Category and Item:
  // List is a container type in Realm allowing us to create a to-many relationship

  let items = List<Item>()
}
