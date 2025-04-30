//
//  ToDoListView.swift
//  ToDoList
//
//  Created by John Kearon on 4/21/25.
//

import SwiftUI
import SwiftData

enum SortOption: String, CaseIterable {
    case asEntered = "As Entered"
    case alphabetical = "A-Z"
    case chronological = "Date"
    case completed = "Not Done"
}

//struct SortedToDos: View {
//    var body: some View {
//     }
//}
struct SortedToDoList: View {
    @Query var toDos: [ToDo]  // Fetches all instances of the attached model type.
    @Environment(\.modelContext) var modelContext  // The SwiftData model context that will be used for queries and other model operations within this environment.
    let sortSelection: SortOption  // data passed to this view
    
    init(sortSelection: SortOption) {
        self.sortSelection = sortSelection
        switch sortSelection {
        case .asEntered:
            _toDos = Query()
        case .chronological:
            _toDos = Query(sort: \.dueDate, order: .forward)
        case .alphabetical:
            _toDos = Query(sort: \.dueDate)
        case .completed:
            _toDos = Query(filter: #Predicate{$0.isCompleted == false})
        }
    }
    
    var body: some View {
        List {  // A container that presents rows of data arranged in a single column, optionally providing the ability to select one or more member
            ForEach(toDos) { toDo in
                VStack (alignment: .leading) {
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
                    HStack {
                        Text(toDo.dueDate.formatted(date: .abbreviated, time: .shortened))
                            .foregroundStyle(.secondary)
                        if toDo.reminderIsOn {
                            Image(systemName: "calendar.badge.clock")
                                .symbolRenderingMode(.multicolor)
                        }
                    }
                }
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
        .listStyle(.plain)
        
    }
}

struct ToDoListView: View {
    //    var toDos = ["Learn Swift",
    //                 "Build Apps",
    //                 "Change the World",
    //                 "Bring the Asesome",
    //                 "Take a Vacation"]
    @State private var sheetIsPresented = false
    @State private var sortSelection: SortOption = .asEntered
    
    var body: some View {
        NavigationStack {
            SortedToDoList(sortSelection: sortSelection)
                .navigationTitle("To Do List")
            //            .navigationBarTitleDisplayMode(.inline)
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
                    
                    ToolbarItem(placement: .bottomBar) {
                        Picker("", selection: $sortSelection) {
                            ForEach(SortOption.allCases, id: \.self) { sortOrder in
                                Text(sortOrder.rawValue)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
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
    //        .modelContainer(for: ToDo.self, inMemory: true)
        .modelContainer(ToDo.preview)
}
