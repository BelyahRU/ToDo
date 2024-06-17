//
//  ContentView.swift
//  ToDo
//
//  Created by Александр Андреев on 17.06.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
        
    }
    let a = TodoItem.parse(json: [
        "id": "1",
        "text": "Buy groceries",
        "importance": "обычная",
        "deadline": "2022-04-30",
        "IsTaskDone": false,
        "creationDate": "2012-04-21",
        "modifiedDate": nil
    ])
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()

    }
}

