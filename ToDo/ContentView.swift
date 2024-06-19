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
        print("OK")
        let item1 = TodoItem.parse(json: [
            "id": "1",
            "text": "Buy groceries",
            "importance": "обычная",
            "deadline": "2022-04-30",
            "IsTaskDone": false,
            "creationDate": "2012-04-21",
            "modifiedDate": nil
        ])
        
        let item2 = TodoItem.parse(json: [
            "id": "2",
            "text": "Buy groceries",
            "importance": "обычная",
            "deadline": "2022-04-30",
            "IsTaskDone": false,
            "creationDate": "2012-04-21",
            "modifiedDate": nil
        ])

        let item3 = TodoItem.parse(json: [
            "id": "3",
            "text": "Buy groceries",
            "importance": "обычная",
            "deadline": "2022-04-30",
            "IsTaskDone": false,
            "creationDate": "2012-04-21",
            "modifiedDate": nil
        ])

        

        
        filecache.add(new: item1!)
        filecache.add(new: item2!)
        filecache.add(new: item3!)
        filecache.saveInFile(fileName: "1.txt")
        print(filecache.uploadFromFile(fileName: "1.txt"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()

    }
}

