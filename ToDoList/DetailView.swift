//
//  DetailView.swift
//  ToDoList
//
//  Created by John Kearon on 4/21/25.
//

import SwiftUI
import SwiftData

struct DetailView: View {
    @State var toDo: ToDo
    @State private var item = ""
    
    @State private var notes = ""
    @State private var isCompleted = false
    @State private var reminderIsOn = false
//    @State private var dueDate Date = Date() + 60 * 60 * 24
    @State private var dueDate = Calendar.current.date(byAdding: .day, value: 1, to: Date.now)!
//    var passedValue: String // Don't initialize it - it will be passed from the parent view
    // \.dismiss  An action that dismisses the current presentation.
    @Environment(\.dismiss) private var dismiss
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

                }
            }

        }
        
    }
}

#Preview {
    NavigationStack {
        DetailView(toDo: ToDo())
            .modelContainer(for: ToDo.self, inMemory: true)
    }
   
}
