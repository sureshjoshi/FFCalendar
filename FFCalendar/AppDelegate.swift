//
//  AppDelegate.swift
//  FFCalendar
//
//  Created by Hive on 4/9/15.
//  Copyright (c) 2015 Fernanda G Geraissate. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        let vc = FFCalendarViewController()
        vc.arrayWithEvents = arrayWithEvents()
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window?.backgroundColor = UIColor.whiteColor()
        self.window?.rootViewController = vc
        self.window?.makeKeyAndVisible()
        
        return true
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
    
    func arrayWithEvents() -> Array<FFEvent> {
        
        let comp = NSDate.componentsOfCurrentDate()
        let date = NSDate.dateWithYear(comp.year, month: comp.month, day: comp.day)
        
        let event1 = FFEvent()
        event1.stringCustomerName = "Customer A"
        event1.numCustomerID = 1
        event1.dateDay = date
        event1.dateTimeBegin = NSDate.dateWithHour(10, min: 00)
        event1.dateTimeEnd = NSDate.dateWithHour(15, min: 13)
        event1.arrayWithGuests = [[111, "Guest 2", "email2@email.com"], [111, "Guest 4", "email4@email.com"], [111, "Guest 5", "email5@email.com"], [111, "Guest 7", "email7@email.com"]]
        
        let event2 = FFEvent()
        event2.stringCustomerName = "Customer B"
        event2.numCustomerID = 2
        event2.dateDay = date
        event2.dateTimeBegin = NSDate.dateWithHour(9, min: 15)
        event2.dateTimeEnd = NSDate.dateWithHour(12, min: 13)
        event2.arrayWithGuests = [[111, "Guest 2", "email2@email.com"], [111, "Guest 4", "email4@email.com"], [111, "Guest 5", "email5@email.com"], [111, "Guest 7", "email7@email.com"]]
        
        let event3 = FFEvent()
        event3.stringCustomerName = "Customer C"
        event3.numCustomerID = 3
        event3.dateDay = date
        event3.dateTimeBegin = NSDate.dateWithHour(16, min: 00)
        event3.dateTimeEnd = NSDate.dateWithHour(17, min: 13)
        event3.arrayWithGuests = [[111, "Guest 2", "email2@email.com"], [111, "Guest 4", "email4@email.com"], [111, "Guest 5", "email5@email.com"], [111, "Guest 7", "email7@email.com"]]
        
        let event4 = FFEvent()
        event4.stringCustomerName = "Customer D"
        event4.numCustomerID = 4
        event4.dateDay = date
        event4.dateTimeBegin = NSDate.dateWithHour(18, min: 00)
        event4.dateTimeEnd = NSDate.dateWithHour(19, min: 13)
        event4.arrayWithGuests = [[111, "Guest 2", "email2@email.com"], [111, "Guest 4", "email4@email.com"], [111, "Guest 5", "email5@email.com"], [111, "Guest 7", "email7@email.com"]]
        
        let event5 = FFEvent()
        event5.stringCustomerName = "Customer E"
        event5.numCustomerID = 5
        event5.dateDay = date
        event5.dateTimeBegin = NSDate.dateWithHour(20, min: 00)
        event5.dateTimeEnd = NSDate.dateWithHour(21, min: 13)
        event5.arrayWithGuests = [[111, "Guest 2", "email2@email.com"], [111, "Guest 4", "email4@email.com"], [111, "Guest 5", "email5@email.com"], [111, "Guest 7", "email7@email.com"]]
        
        let event9 = FFEvent()
        event9.stringCustomerName = "Customer I"
        event9.numCustomerID = 5
        event9.dateDay = date
        event9.dateTimeBegin = NSDate.dateWithHour(20, min: 00)
        event9.dateTimeEnd = NSDate.dateWithHour(21, min: 13)
        event9.arrayWithGuests = [[111, "Guest 2", "email2@email.com"], [111, "Guest 4", "email4@email.com"], [111, "Guest 5", "email5@email.com"], [111, "Guest 7", "email7@email.com"]]

        
        let event6 = FFEvent()
        event6.stringCustomerName = "Customer F"
        event6.numCustomerID = 6
        event6.dateDay = NSDate.dateWithYear(comp.year, month: comp.month, day: 25)
        event6.dateTimeBegin = NSDate.dateWithHour(20, min: 00)
        event6.dateTimeEnd = NSDate.dateWithHour(21, min: 13)
        event6.arrayWithGuests = [[111, "Guest 2", "email2@email.com"], [111, "Guest 4", "email4@email.com"], [111, "Guest 5", "email5@email.com"], [111, "Guest 7", "email7@email.com"]]
        
        let event7 = FFEvent()
        event7.stringCustomerName = "Customer G"
        event7.numCustomerID = 7
        event7.dateDay = NSDate.dateWithYear(comp.year, month: comp.month, day: 1)
        event7.dateTimeBegin = NSDate.dateWithHour(20, min: 00)
        event7.dateTimeEnd = NSDate.dateWithHour(21, min: 13)
        event7.arrayWithGuests = [[111, "Guest 2", "email2@email.com"], [111, "Guest 4", "email4@email.com"], [111, "Guest 5", "email5@email.com"], [111, "Guest 7", "email7@email.com"]]
        
        let event8 = FFEvent()
        event8.stringCustomerName = "Customer H"
        event8.numCustomerID = 8
        event8.dateDay = NSDate.dateWithYear(comp.year, month: comp.month, day: 2)
        event8.dateTimeBegin = NSDate.dateWithHour(20, min: 00)
        event8.dateTimeEnd = NSDate.dateWithHour(21, min: 13)
        event8.arrayWithGuests = [[111, "Guest 2", "email2@email.com"], [111, "Guest 4", "email4@email.com"], [111, "Guest 5", "email5@email.com"], [111, "Guest 7", "email7@email.com"]]
        
        return [event1, event2, event3, event4, event5, event6, event7, event8, event9]
    }
}

