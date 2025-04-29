//
//  ToDoListView.swift
//  ToDoList
//
//  Created by John Kearon on 4/21/25.
//

import SwiftUI
import SwiftData

struct ToDoListView: View {
//    var toDos = ["Learn Swift",
//                 "Build Apps",
//                 "Change the World",
//                 "Bring the Asesome",
//                 "Take a Vacation"]
    @Query var toDos: [ToDo]  // Fetches all instances of the attached model type.
    @State private var sheetIsPresented = false
    @Environment(\.modelContext) var modelContext  // The SwiftData model context that will be used for queries and other model operations within this environment.

    var body: some View {
        NavigationStack {
            List {  // A container that presents rows of data arranged in a single column, optionally providing the ability to select one or more member
                ForEach(toDos) { toDo in
                    HStack {
                        Image(systemName: toDo.isCompleted ? "checkmark.rectangle" : "rectangle")
                            .onTapGesture {
                                toDo.isCompleted.toggle()
                                guard let _ = try? modelContext.save() else {
                                    print("😡 ERROR: Save after .isCompleted.toggle on ToDoListView did not work.")
                                    return
                                }
                            }
                        
                        NavigationLink {
                            DetailView(toDo: toDo)  // passes the selected row's SwiftData object to the destination view
                        } label: {
                            Text(toDo.item)
                        }
                       
                        .swipeActions {
                            Button("Delete", role: .destructive) {
                                modelContext.delete(toDo)
                                guard let _ = try? modelContext.save() else {
                                    print("😡 ERROR: Save after .delete on ToDoListView did not work.")
                                    return
                                }
                            }
                        }
                    }
                    .font(.title2)
                }
                // Alternate old method for deletions
//                .onDelete { indexSet in
//                    indexSet.forEach({modelContext.delete(toDos[$0])})
//                    guard let _ = try? modelContext.save() else {
//                        print("😡 ERROR: Save after .delete on ToDoListView did not work.")
//                        return
//                    }
//                 }
                
            }
            .navigationTitle("To Do List")
            //            .navigationBarTitleDisplayMode(.inline)
            .listStyle(.plain)
//            .fullScreenCover(item: $sheetIsPresented, content: { <#Identifiable#> in
//                <#code#>
//            })
            .sheet(isPresented:$sheetIsPresented) {
                NavigationStack { //  A view that displays a root view and enables you to present additional views over the root view.
                    DetailView(toDo: ToDo())
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        sheetIsPresented.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                    
                }
                //                 ToolbarItem(placement: .topBarTrailing) {
                //                     Button("", systemImage: "plus") {
                //                         //TODO: add create new to do list item
                //                     }
            }
            
        }
        
    }
}

#Preview {
    ToDoListView()
        .modelContainer(for: ToDo.self, inMemory: true)
}
