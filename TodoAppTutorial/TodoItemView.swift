//
//  TodoItemView.swift
//  TodoAppTutorial
//
//  Created by Dmitriy Shin on 2020-07-27.
//  Copyright © 2020 dmitriyshin.io. All rights reserved.
//

import SwiftUI

struct TodoItemView: View {
  var title: String = ""
  var createdAt: String = ""

  var body: some View {
    HStack {
      VStack(alignment: .leading) {
        Text(title).font(.headline)
        Text(createdAt).font(.caption)
      }
    }
  }
}

struct TodoItemView_Previews: PreviewProvider {
  static var previews: some View {
    TodoItemView(title: "My great todo", createdAt: "Today")
  }
}
