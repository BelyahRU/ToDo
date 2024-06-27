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
    @State private var deadline: Date? = nil
    @State private var isTaskDone: Bool = false
    @State private var creationDate: Date = Date()
    @State private var modifiedDate: Date? = nil

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
            .background(Resources.LightTheme.Back.primaryColor)
            .onAppear {
                text = todoItem?.text ?? ""
            }
        }
        .background(Resources.LightTheme.Back.primaryColor)
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

    }
    
    var cancelButton: some View {
        Button {
            print("Отменить")
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            Text("Отменить")
                .font(.system(size: 17))
        }

    }
    
    var list: some View {
        VStack(spacing: 0) {
            importanceHStack
                .frame(height: 56)
                .padding(.horizontal, 16)
                .background(Color.white)
            Divider().background(Color.gray.opacity(0.5))
            deadlineHStack
                .frame(height: 56)
                .padding(.horizontal, 16)
                .background(Color.white)
        }
            .frame(height: 112.5)
            .background(Color.white)
            .cornerRadius(16)
            .padding(.horizontal)
    }
        
    var importanceHStack: some View {
        HStack {
            Text("Важность")
                .font(.system(size: 17))
            Spacer()
            // Ваши кнопки важности
            Button(action: {
                // действие для изменения важности
            }) {
                Text("низкая")
            }
            Button(action: {
                // действие для изменения важности
            }) {
                Text("нет")
            }
            Button(action: {
                // действие для изменения важности
            }) {
                Text("!!")
            }
        }
    }

    var deadlineHStack: some View {
        HStack {
            Text("Сделать до")
                .font(.system(size: 17))
            Spacer()
            Toggle(isOn: $isTaskDone) {
                Text("")
            }
            .toggleStyle(SwitchToggleStyle())
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
