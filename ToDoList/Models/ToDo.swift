//
//  ToDo.swift
//  ToDoList
//
//  Created by John Kearon on 4/25/25.
//

import Foundation
import SwiftData

//  Model() Converts a Swift class into a stored model that’s managed by SwiftData.
//  Annotate your model classes with the @Model macro to make them persistable. At build time, the macro expands to provide conformance to the PersistentModel and Observable protocols.
@MainActor   // A singleton actor whose executor is equivalent to the main dispatch queue. Enables tasks that typically do not run on the main thread (loading mock data) to run on the main thread
@Model
class ToDo {
    var item: String = ""
    var notes = ""
    var isCompleted = false
    var reminderIsOn = false
    var dueDate = Date.now + 60 * 60 * 24
    
    init(item: String = "", notes: String = "", isCompleted: Bool = false, reminderIsOn: Bool = false, dueDate: Date = Date.now + 60 * 60 * 24) {
        self.item = item
        self.notes = notes
        self.isCompleted = isCompleted
        self.reminderIsOn = reminderIsOn
        self.dueDate = dueDate
    }
        
}

extension ToDo {
    static var preview: ModelContainer {
        let container = try! ModelContainer(for: ToDo.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        
        // add mock data
        container.mainContext.insert(ToDo(item: "Create SwiftData Lessons", notes: "Now with iOS 16 & Xcode 18", isCompleted: false, reminderIsOn: false, dueDate: Date.now + 60*60*24))
        container.mainContext.insert(ToDo(item: "Macedonian Educators Talk", notes: "They want to learn about entrepreneurship", isCompleted: false, reminderIsOn: true, dueDate: Date.now + 60*60*44))
        container.mainContext.insert(ToDo(item: "Post Flyers for Swift in Santiago", notes: "To be held in UAH in Chile", isCompleted: false, reminderIsOn: true, dueDate: Date.now + 60*60*72))
        container.mainContext.insert(ToDo(item: "Prepare old iPhone for Lily", notes: "Now with iOS 16 & Xcode 18", isCompleted: false, reminderIsOn: true, dueDate: Date.now + 60*60*24))
        
        return container
    }

}
