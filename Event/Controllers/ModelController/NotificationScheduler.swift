//
//  NotificationScheduler.swift
//  Event
//
//  Created by Lee McCormick on 1/22/21.
//

import UserNotifications

class NotificationScheduler {
    
    // MARK: - Schedule Notifications
    func scheduleNotification(event: Event) {
        
        guard let eventDate = event.date,
              let eventId = event.id else { return }
        
        let content = UNMutableNotificationContent()
        content.title = "REMINDER !"
        content.body = "It is time for \(event.title ?? "event")"
        content.sound = .default
        let dateComponents = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute], from: eventDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: eventId, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Unable to add notification request: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Cancel Notification
    func cancelNofication(event: Event) {
        guard let eventId = event.id else { return }
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [eventId])
    }
}


