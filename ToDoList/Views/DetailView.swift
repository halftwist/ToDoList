//
//  DetailView.swift
//  ToDoList
//
//  Created by John Kearon on 4/21/25.
//

import SwiftUI
import SwiftData

struct DetailView: View {
    @State var toDo: ToDo  // single Swift Data object
    @State private var item = ""
    @State private var notes = ""
    @State private var isCompleted = false
    @State private var reminderIsOn = false
//    @State private var dueDate Date = Date() + 60 * 60 * 24
    @State private var dueDate = Calendar.current.date(byAdding: .day, value: 1, to: Date.now)!
//    var passedValue: String // Don't initialize it - it will be passed from the parent view
    // \.dismiss  An action that dismisses the current presentation.
//   @Environment: A property wrapper that reads a value from a view’s environment.
    @Environment(\.dismiss) private var dismiss
//  modelContext The SwiftData model context that will be used for queries and other model operations within this environment.
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        List {
            TextField("Enter To Do here", text: $item)
                .font(.title)
                .textFieldStyle(.roundedBorder)
                .padding(.vertical)
                .listRowSeparator(.hidden)
            
            Toggle("Set Reminder", isOn: $reminderIsOn)
                .padding(.top)
                .listRowSeparator(.hidden)
            
            DatePicker("Date:", selection: $dueDate)
                .listRowSeparator(.hidden)
                .padding(.bottom)
                .disabled(!reminderIsOn)
            
            Text("Notes:")
                .padding(.top)
            
            TextField("Notes", text: $notes, axis: .vertical)
                .textFieldStyle(.roundedBorder)
                .listRowSeparator(.hidden)
            
            Toggle("Completed", isOn: $isCompleted)
                .padding(.top)
                .listRowSeparator(.hidden)


        }
        .listStyle(.plain)
        .onAppear() {
            // Move data from toDo opject to local vars
            item = toDo.item
            reminderIsOn = toDo.reminderIsOn
            dueDate = toDo.dueDate
            notes = toDo.notes
            isCompleted = toDo.isCompleted
        }
        .navigationBarBackButtonHidden()  // hides the default back button
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    // Move data from local vars to toDo object
                    toDo.item = item
                    toDo.reminderIsOn = reminderIsOn
                    toDo.dueDate = dueDate
                    toDo.notes = notes
                    toDo.isCompleted = isCompleted
                    modelContext.insert(toDo)
                    // debugging code
//  save() Writes any pending inserts, changes, and deletes to the persistent storage.
                    guard let _ = try? modelContext.save() else {
                        print("😡 ERROR: Save on DetailView did not work.")
                        return
                    }
                    dismiss()  // dismiss or close the current view
                }
            }

        }
        
    }
}

#Preview {
    NavigationStack {
        DetailView(toDo: ToDo())  // 
            .modelContainer(for: ToDo.self, inMemory: true)
    }
   
}
