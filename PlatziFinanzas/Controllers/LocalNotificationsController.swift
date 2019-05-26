//
//  LocalNotificationsController.swift
//  PlatziFinanzas
//
//  Created by Manuel Alejandro Aguilar Tellez Giron on 5/7/19.
//  Copyright © 2019 Manuel Alejandro Aguilar Tellez Giron. All rights reserved.
//

import Foundation
import UserNotifications

class LocalNotificationsController {
    init () {
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { (success, error) in
                self.addNotifications()
        }
        
    }
    
    
    func addNotifications() {
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        
        
        content.title = "¿Hiciste alguna compra en el día?"
        content.body = "No olvides agregar tus gastos diarios"
        content.sound = UNNotificationSound.default
 
        
        var date = DateComponents()
        
        //To notificte every day at certain hour
        date.hour = 19
        date.minute = 30
        date.second = 0
        date.timeZone = .current
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        //let trigger = UNCalendarNotificationTrigger(

        
        let request = UNNotificationRequest(
            identifier: "inTenSeconds",
            content: content,
            trigger: trigger
        )
        
        center.add(request) { (error) in
            guard let error = error else { return }
            
            print(error.localizedDescription)
        }
    }
}
