//
//  AppDelegate.swift
//  Line Jumpr
//
//  Created by Tony Martini on 2/4/21.
//

import UIKit
import UserNotifications
import GoogleMobileAds
@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        
        return true
        
        
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        let newcontent = UNMutableNotificationContent()
            newcontent.title = "Come Back!"
            newcontent.body = "We Miss You"
            newcontent.sound = UNNotificationSound.default
            
            //259200
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 259200, repeats: false)
            
        
            
            let request2 = UNNotificationRequest(identifier: "testidentifier", content: newcontent, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request2, withCompletionHandler: nil)
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }


}

