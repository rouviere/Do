//  AppDelegate.swift
//  Do
//
//  Created by Forrest M Anderson on 5/3/18.
//  Copyright © 2018 Rouviere Media. All rights reserved.

import UIKit
import CoreData
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
  print(Realm.Configuration.defaultConfiguration.fileURL)
    
    do {
      let realm = try Realm()
      try realm.write {
      }
    } catch {
      print("There was an error creating a new realm \(error)")
    }
    
    
    return true
  }

  func applicationWillTerminate(_ application: UIApplication) {

  
  }

}
