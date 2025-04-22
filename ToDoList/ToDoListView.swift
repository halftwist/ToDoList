//
//  ToDoListView.swift
//  ToDoList
//
//  Created by John Kearon on 4/21/25.
//

import SwiftUI

struct ToDoListView: View {
    var body: some View {
        NavigationStack {
            List {
                ForEach(0..<100, id: \.self) { number in
                    NavigationLink {
                        DetailView(passedValue: "Item \(number)")
                    } label: {
                        Text("Item \(number)")
                    }

                    
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
            .navigationTitle("School Year")
//            .navigationBarTitleDisplayMode(.inline)
            .listStyle(.plain)
        }
        
    }
}

#Preview {
    ToDoListView()
}
