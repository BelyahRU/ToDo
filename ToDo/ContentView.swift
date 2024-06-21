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
    
    let start = Start()
    
    
}

struct Start {
    
    let filecache = FileCache()
    
    init() {
        setup()
    }
    
    func setup() {
        let todoItem = TodoItem(id: "1", text: "покрасить забор", importance: Importance.ordinary, deadline: nil, isTaskDone: true, creationDate: Date(), modifiedDate: nil)
        let invalidJson: [String: Any] = [
            "id": "123",
            "text": "Test Task",
            "creationDate": Date() // Использование строки даты вместо объекта Date
        ]
        let answ = TodoItem.parse(json: invalidJson)
        print(answ)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()

    }
}

