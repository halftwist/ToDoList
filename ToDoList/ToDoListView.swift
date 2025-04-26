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
    @Query var toDos: [ToDo]
    @State private var sheetIsPresented = false
    @Environment(\.modelContext) var modelContext

    
    var body: some View {
        NavigationStack {
            List {
                ForEach(toDos) { toDo in
                    NavigationLink {
                        DetailView(toDo: toDo)
                    } label: {
                        Text(toDo.item)
                    }
                    .font(.title2)
                    
                    
                }
                
                //                Section {
                //                    NavigationLink {
                //                        DetailView()
                //                    } label: {
                //                        Text("Winter")
                //                    }
                //                    Text("Summer")
                //                } header: {
                //                    Text("Breaks")
                //                }
                //
                //                Section {
                //                    NavigationLink {
                //                        DetailView()
                //                    } label: {
                //                        Text("Spring")
                //                    }
                //                    Text("Fall")
                //                } header: {
                //                    Text("Semesters")
                //                }
                
            }
            .navigationTitle("To Do List")
            //            .navigationBarTitleDisplayMode(.inline)
            .listStyle(.plain)
//            .fullScreenCover(item: $sheetIsPresented, content: { <#Identifiable#> in
//                <#code#>
//            })
            .sheet(isPresented:$sheetIsPresented) {
                NavigationStack {
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
