//
//  ViewController.swift
//  Huli Pizza 2
//
//  Created by Christopher D Fontana on 9/5/17.
//  Copyright © 2017 Christopher D Fontana. All rights reserved.
//


// this app is how to do basic simple local ios Notifications. I'll have a second one for how to do notification management.
import UIKit
import UserNotifications

class ViewController: UIViewController, UNUserNotificationCenterDelegate {
    
    var isGrantedNotificationsAccess = false

    func makePizzaContent() -> UNMutableNotificationContent{
        let content = UNMutableNotificationContent()
        content.title = "A Timed Pizza Step"
        content.body = "Making Pizza"
        content.userInfo = ["step":0]
        return content
    }
    
    func addNotification(trigger:UNNotificationTrigger?, content:UNMutableNotificationContent, identifier:String){
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request){
            (error) in
            if error != nil {
                print("error adding notification: \(error?.localizedDescription)")
            }
        }
    }
    
    
    @IBAction func schedulePizza(_ sender: UIButton) {
        
        if isGrantedNotificationsAccess{
            let content = UNMutableNotificationContent()
            content.title = "A Scheduled Pizza"
            content.body = "Time to make a pizza"
            
            let unitFlags:Set<Calendar.Component> = [.minute, .hour, .second]
            var date = Calendar.current.dateComponents(unitFlags, from: Date())
            date.second = date.second! + 15
            
            // another trigger
            let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: false)
            
            addNotification(trigger: trigger, content: content, identifier: "message.scheduleda")
        }
    }
    
    
    @IBAction func makePizza(_ sender: UIButton) {
        
        if isGrantedNotificationsAccess{
        
            let content = makePizzaContent()
            // this is the notification trigger for a timed notification
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10.0, repeats: false)
            
            addNotification(trigger: trigger, content: content, identifier: "message.pizza")
        }
    }
    
    
    @IBAction func nextPizzaStep(_ sender: UIButton) {
    }
    
    
    @IBAction func viewPendingNotifications(_ sender: UIButton) {
    }
    
    
    @IBAction func viewDeliveredNotifications(_ sender: UIButton) {
    }
    
    
    @IBAction func removeNotification(_ sender: UIButton) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // this tells the delegate to look for notification center here
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge,.sound]) {(granted,error) in
            self.isGrantedNotificationsAccess=granted
            if !granted {
                //add alert to complain to loser
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //MARK: -Delegates
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void){
        completionHandler([.alert, .sound])
    }
    
    
    
    
    
    
    
    

}

