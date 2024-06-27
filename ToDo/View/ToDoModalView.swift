//
//  AddToDoModalView.swift
//  ToDo
//
//  Created by Александр Андреев on 26.06.2024.
//

import SwiftUI
struct ToDoModalView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var todoItem: TodoItem?
    @State private var text: String = ""
    @State private var importanse: Importance = .ordinary

    var body: some View {
        mainNavigationStack
    }
    
    var mainNavigationStack: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    textEditor
                    Spacer()
                    list
                        .background(.black)
                    Spacer()
                    removeButton
                }
                .navigationTitle("Дело")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarLeading) {
                        cancelButton
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        saveButton
                    }
                })
                .background(Resources.LightTheme.Back.primaryColor)
            }
            .onAppear {
                text = todoItem?.text ?? ""
            }
        }
    }
    
    
    var textEditor: some View {
        TextEditor(text: $text)
            .frame(minHeight: 120)
            .background(Color.white)
            .cornerRadius(16)
            .padding(.horizontal)
    }
    
    var saveButton: some View {
        Button {
            print("save")
        } label: {
            Text("Сохранить")
                .font(.system(size: 17))
                .fontWeight(.bold)
        }
        .frame(width: 105)
        .frame(height: 56)

    }
    
    var cancelButton: some View {
        Button {
            print("Отменить")
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            Text("Отменить")
                .font(.system(size: 17))
        }
        .frame(width: 105)
        .frame(height: 56)

    }
    
    var list: some View {
        List {
            importanceHStack
            deadlineHStack
        }
        .cornerRadius(16)
        .frame(minWidth: 343)
        .listStyle(PlainListStyle())
    }

    var importanceHStack: some View {
        HStack {

        }
    }

    var deadlineHStack: some View {
        HStack {

        }
    }

    var removeButton: some View {
        Button {
            print("sfdgsef")
        } label: {
            Text("Удалить")
                .foregroundColor(Resources.LightTheme.redColor)

        }
        .frame(height: 56)
        .frame(minWidth: 343)
        .background(Resources.LightTheme.whiteColor)
        .cornerRadius(16)

    }
    
    private func saveTodoItem() {
        if let _ = todoItem {
//            self.todoItem?.text = text
        } else {
//            todoItem = TodoItem(text: text, isTaskDone: false)
        }
    }
}

    

struct AddToDoModalView_Previews: PreviewProvider {
    @State static var examleToDoItem: TodoItem? = TodoItem(text: "sdfgsdfg", importance: .important, deadline: Date(), isTaskDone: true, creationDate: Date(), modifiedDate: nil)
    static var previews: some View {
        ToDoModalView(todoItem: $examleToDoItem)
    }
}
