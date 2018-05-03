//
//  AppDelegate.swift
//  Do
//
//  Created by Forrest M Anderson on 5/3/18.
//  Copyright © 2018 Rouviere Media. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    // path to the NSUserDefaults directory that stores the Plist that holds our data.
    print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)
    
    
   //  print("didFinishLaunchingWithOptions")
    
    return true
  }

  func applicationWillResignActive(_ application: UIApplication) {
    
   //  print("applicationWillResignActive")
    
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
    // print("applicationDidEnterBackground")
  }

  func applicationWillEnterForeground(_ application: UIApplication) {
   // print("applicationWillEnterForeground")
  }

  func applicationDidBecomeActive(_ application: UIApplication) {
    // print("applicationDidBecomeActive")
  }

  func applicationWillTerminate(_ application: UIApplication) {
    // print("applicationWillTerminate")
  }


}

