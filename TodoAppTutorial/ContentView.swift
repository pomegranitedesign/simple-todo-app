//
//  ContentView.swift
//  TodoAppTutorial
//
//  Created by Dmitriy Shin on 2020-07-27.
//  Copyright © 2020 dmitriyshin.io. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  @Environment(\.managedObjectContext) var managedObjectContext
  @FetchRequest(fetchRequest: TodoItem.getAllTodoItems()) var todoItems: FetchedResults<TodoItem>
  
  @State private var newTodoItem = ""
  @State private var isErrorShown = false
  
  var body: some View {
    NavigationView {
      List {
        Section(header: Text("What's Next?")) {
          HStack {
            TextField("New Item", text: self.$newTodoItem)
            Button(action: {
              let todoItem = TodoItem(context: self.managedObjectContext)
              
              if self.newTodoItem.count == 0 {
                self.isErrorShown = true
              }
              
              todoItem.title = self.newTodoItem
              todoItem.createdAt = Date()
              
              do {
                try self.managedObjectContext.save()
              } catch {
                print(error)
              }
              
              self.newTodoItem = ""
            }) {
              Image(systemName: "plus.circle.fill").foregroundColor(.green).imageScale(.large)
            }
          }
        }.font(.headline).alert(isPresented: $isErrorShown) {
          Alert(title: Text("Empty Todo"), message: Text("Please Enter the Todo title"))
        }
        
        Section(header: Text("Todos")) {
          ForEach(self.todoItems) { todoItem in
            TodoItemView(title: todoItem.title!, createdAt: "\(todoItem.createdAt!)")
          }.onDelete { indexSet in
            let deleteItem = self.todoItems[indexSet.first!]
            self.managedObjectContext.delete(deleteItem)
            
            do {
              try self.managedObjectContext.save()
            } catch {
              print(error)
            }
          }
        }
      }
      .navigationBarTitle(Text("My List"))
      .navigationBarItems(trailing: EditButton())
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
