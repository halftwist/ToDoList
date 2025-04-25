//
//  ToDo.swift
//  ToDoList
//
//  Created by John Kearon on 4/25/25.
//

import Foundation
import SwiftData

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

