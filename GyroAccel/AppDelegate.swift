//
//  AppDelegate.swift
//  GyroAccel
//
//  Created by Andrew Genualdi on 2/18/16.
//  Copyright © 2016 Andrew Genualdi. All rights reserved.
//

import UIKit
import Foundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var httpServer = HTTPServer()


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.

        httpServer.setConnectionClass(MyHTTPConnection)

//        let test :MyHTTPConnection = MyHTTPConnection()
//        let gManager = GyroManager.sharedGyroManager()
//        test.story = gManager.gyroVal
        
        let stringtype = "_http._tcp."
        httpServer.setType(stringtype)
                
        let mainBundle = NSBundle.mainBundle()
        let path: NSString! = mainBundle.resourcePath
        let webPath = path.stringByAppendingPathComponent("")
        print(webPath)
        httpServer.setDocumentRoot(webPath)
        self.startServer()
        return true
        
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        httpServer.stop()
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        self.startServer()
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func startServer(){
        do {
            try httpServer.start()
            print("Sucess")
            print(httpServer.listeningPort())
        } catch let error as NSError {
            print(error)
        }
    }
    
    func getPortNumber() -> UInt16{
        return httpServer.listeningPort()
    }


}

