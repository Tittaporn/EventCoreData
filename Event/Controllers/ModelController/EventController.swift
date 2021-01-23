//
//  EventController.swift
//  Event
//
//  Created by Lee McCormick on 1/22/21.
//

import CoreData

class EventController {
    
    // MARK: - Properties
    static let shared = EventController()
    var sections: [[Event]] {[attendingEvents, notAttendingEvents]}
    var attendingEvents: [Event] = []
    var notAttendingEvents: [Event] = []
    private lazy var fetchRequest: NSFetchRequest<Event> = {
        let request = NSFetchRequest<Event>(entityName: "Event")
        request.predicate = NSPredicate(value: true)
        return request
    }()
    let notificationScheduler = NotificationScheduler()
    
    // MARK: - CRUD Methods
    // CREATE
    func creatEvent(title: String, date: Date) {
        let newEvent = Event(title: title, date: date)
        notAttendingEvents.append(newEvent)
        CoreDataStack.saveContext()
        notificationScheduler.scheduleNotification(event: newEvent)
    }
    
    // READ
    func fetchEvents() {
        let events = (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
        attendingEvents = events.filter{$0.attendingStatus}
        notAttendingEvents = events.filter{!$0.attendingStatus}
    }
    
    // UPDATE
    func updateEvent(event: Event, title: String, date: Date) {
        notificationScheduler.cancelNofication(event: event)
        event.title = title
        event.date = date
        CoreDataStack.saveContext()
        notificationScheduler.scheduleNotification(event: event)
    }
    
    func toggleAttendingStatus(event: Event) {
        event.attendingStatus.toggle()    
        
        if event.attendingStatus {
            if let index = notAttendingEvents.firstIndex(of: event) {
                notAttendingEvents.remove(at: index)
                attendingEvents.append(event)
            }
        } else {
            if let index = attendingEvents.firstIndex(of: event) {
                attendingEvents.remove(at: index)
                notAttendingEvents.append(event)
            }
        }
        
        CoreDataStack.saveContext()
    }
    
    // DELETE
    func deleteEvent(event: Event) {
        CoreDataStack.context.delete(event)
        notificationScheduler.cancelNofication(event: event)
        CoreDataStack.saveContext()
        fetchEvents()
    }
}
