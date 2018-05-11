//
//  Item.swift
//  Do
//
//  Created by Forrest M Anderson on 5/11/18.
//  Copyright © 2018 Rouviere Media. All rights reserved.
//

import Foundation

import Foundation
import RealmSwift

class Item: Object {
  @objc dynamic var title: String = ""
  @objc dynamic var done: Bool = false
  @objc dynamic var dateCreated: Date?
  
  // To establish the relationship to the Category class we using LinkingObjects option + to see more:
  var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
