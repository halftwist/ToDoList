//
//  ToDoListView.swift
//  ToDoList
//
//  Created by John Kearon on 4/21/25.
//

import SwiftUI

struct ToDoListView: View {
    var body: some View {
        var toDos = ["Learn Swift",
                     "Build Apps",
                     "Change the World",
                     "Bring the Asesome",
                     "Take a Vacation"]
        NavigationStack {
            List {
                ForEach(toDos, id: \.self) { todo in
                    NavigationLink {
                        DetailView(toDo: todo)
                    } label: {
                        Text(todo)
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
        }
        
    }
}

#Preview {
    ToDoListView()
}
