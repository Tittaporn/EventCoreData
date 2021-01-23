//
//  Event+Convenience.swift
//  Event
//
//  Created by Lee McCormick on 1/22/21.
//

import CoreData

extension Event {
    @discardableResult convenience init(title: String, date: Date, attendingStatus: Bool = false, id: String = UUID().uuidString, context: NSManagedObjectContext = CoreDataStack.context){
        self.init(context: context)
        self.title = title
        self.date = date
        self.attendingStatus = attendingStatus
        self.id = id
    }
}
