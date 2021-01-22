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
    var events: [Event] = []
    private lazy var fetchRequest: NSFetchRequest<Event> = {
        let request = NSFetchRequest<Event>(entityName: "Event")
        request.predicate = NSPredicate(value: true)
        return request
    }()
    
    // MARK: - CRUD Methods
    // CREATE
    func creatEvent(title: String, date: Date) {
        let newEvent = Event(title: title, data: date)
        events.append(newEvent)
        CoreDataStack.saveContext()
    }
    
    // READ
    func fetchEvents() {
        events = (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
    }
    
    // UPDATE
    func updateEvent(event: Event, title: String, date: Date) {
        event.title = title
        event.date = date
        CoreDataStack.saveContext()
    }
    
    func toggleAttendingStatus(event: Event) {
        event.attendingStatus.toggle()
        CoreDataStack.saveContext()
    }
    
    // DELETE
    func deleteEvent(event: Event) {
        CoreDataStack.context.delete(event)
        CoreDataStack.saveContext()
        fetchEvents()
    }
}
