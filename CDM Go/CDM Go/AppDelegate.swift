//
//  AppDelegate.swift
//  CDM Go
//
//  Created by Developer on 27/08/15.
//  Copyright (c) 2015 OFS. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var isLoggedIn : Bool = false
    var deviceToken :String!
    var userID:String!
    var projects : AnyObject!
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        var storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        if (isLoggedIn)
        {
            var controller :UIViewController = storyBoard.instantiateViewControllerWithIdentifier("ProjectViewController") as! UIViewController
            
           // self.window?.rootViewController = navController
        }
        else
        {
             var controller :UIViewController = storyBoard.instantiateViewControllerWithIdentifier("ViewController") as! UIViewController
            var navController :UINavigationController = UINavigationController(rootViewController: controller)
            self.window?.rootViewController = navController
        }
        
        let settings = UIUserNotificationSettings(forTypes: .Alert, categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
        UIApplication.sharedApplication().registerForRemoteNotifications()
        
        return true
    }
    
    // implemented in your application delegate
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        let userInformationStorage = NSUserDefaults.standardUserDefaults()
        if let userIDFromService: String = userInformationStorage.objectForKey(InvokeService.USERIDJSONKEY) as? String
        {
            self.userID = userIDFromService
            println("Got token data! \(deviceToken)")
            InvokeService.updateDeviceToken(deviceToken.description, userId:  self.userID)        }
        
        }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {

        println("Couldn't register: \(error)")
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    func application(application: UIApplication, handleWatchKitExtensionRequest userInfo: [NSObject : AnyObject]?, reply: (([NSObject : AnyObject]!) -> Void)!) {
        //var project :[Project] = ProjectsViewController.sampleData()
       
        if let type = userInfo!["Project"] as? String
        {
            if(type == "get")
            {
                if(self.userID != nil)
                {
                    self.projects = syncData()                    
                    reply(["project" : self.projects])
                }
                else
                {
                    reply(["project":"Failure"])
                }
            }
        }
    }

    func syncData() -> AnyObject?{
        var projectData : AnyObject!
        let (projectfromService: AnyObject?,status) = InvokeService.getProject("aaaa")
        if(projectfromService != nil)
        {
                projectData =  projectfromService
        }
        else{
                showErrorAlertMessage()
        }
        
        return projectData
    }
    func showErrorAlertMessage()
    {
        var alert = UIAlertView(title: "Projects", message: "Some Error had incurred", delegate: self, cancelButtonTitle: "OK")
    }
    static func getActivityIndicator(uiView: UIView) -> UIActivityIndicatorView
    {
        var actInd: UIActivityIndicatorView = UIActivityIndicatorView()
        actInd.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
        actInd.center = uiView.center
        actInd.hidesWhenStopped = true
        actInd.activityIndicatorViewStyle =
            UIActivityIndicatorViewStyle.WhiteLarge
        uiView.addSubview(actInd)
        return actInd
    }
}

