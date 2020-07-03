//
//  MyNotification.swift
//  BlessYou
//
//  Created by Mor Soferian on 6/29/20.
//  Copyright © 2020 Mor Soferian. All rights reserved.
//

import Foundation
import UserNotifications

class Notification {
    
    var content = UNMutableNotificationContent()
    
    init() {
        requestAuthorization()
        content.sound = UNNotificationSound.default
    }
    
    private func requestAuthorization(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        print("All set!")
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
            }
    }
    
    func setContent(title: String!, subtitle: String!){
        content.title = title
        content.subtitle = subtitle
    }
    
    func trigger(month: Int, day: Int){
        // show this notification five seconds from now
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 20, repeats: false)
        // choose a random identifier
//        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        // add our notification request
//        UNUserNotificationCenter.current().add(request)
        
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.hour = 10
        dateComponents.minute = 30
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)

    }
    
}

//Cancel a Scheduled Notification Request
//Once scheduled, a notification request remains active until its trigger condition is met, or you explicitly cancel it. Typically, you cancel a request when conditions change and you no longer need to notify the user. For example, if the user completes a reminder, you would cancel any active requests associated with that reminder. To cancel an active notification request, call the removePendingNotificationRequests(withIdentifiers:) method of UNUserNotificationCenter.
