//
//  AppDelegate.swift
//  DoorUnlocker
//
//  Created by Andrew Bartow on 1/8/19.
//  Copyright © 2019 Andrew Bartow. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, BeaconMonitorDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
    var deviceConnection: BleDeviceConnection?
    var beaconMonitor: BeaconMonitor?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        deviceConnection = BleDeviceConnection()
        beaconMonitor = BeaconMonitor()
        beaconMonitor!.delegate = self;
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.requestAuthorization(options: [.alert, .sound], completionHandler: {_,_ in });
        return true
    }
    
    func onNearBeacon() {
        let content = UNMutableNotificationContent()
        content.title = "Door Detected!"
        content.body = "Detected iBeacon on the door. Now is when I'd try to connect to the NRF52."
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = "door-nearby"
        
        let request = UNNotificationRequest.init(identifier: "door-nearby", content: content, trigger: nil)
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request)
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

