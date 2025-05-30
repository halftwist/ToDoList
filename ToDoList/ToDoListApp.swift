//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by John Kearon on 4/21/25.
//

import SwiftUI
import SwiftData

@main
struct ToDoListApp: App {
    var body: some Scene {
        WindowGroup {
            ToDoListView()
                .modelContainer(for: ToDo.self)   // for:modelType The model type defining the schema used to create the model container.
        }
    }
    
    // will allow us to find where our simulator data is saved:
    init() {
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
}
