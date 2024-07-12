//
//  AddToDoModalView.swift
//  ToDo
//
//  Created by Александр Андреев on 26.06.2024.
//

import SwiftUI

enum CurrentFramework {
    case swiftUI
    case UIkit
}
// viewModels - observers filecache
struct ToDoModalView: View {
    @Environment(\.presentationMode)
    var presentationMode
    
    @Binding var todoItem: TodoItem?
    var currentFramework: CurrentFramework
    @EnvironmentObject var viewModel: MainViewModel
    
    @State private var text: String = "Что надо сделать?"
    @State private var importance: Importance = .unimportant
    @State private var deadline: Date?
    @State private var isTaskDone: Bool = false
    @State private var creationDate: Date = Date()
    @State private var modifiedDate: Date?

    @State private var selectedImportanceIndex = 0
    @State private var switchIsOn: Bool = false
    @State private var datePickerIsOn: Bool = false
    @State private var category: Category = Category(categoryName: "Другое", categoryColor: .init(color: .clear))

    var body: some View {
        mainNavigationStack
    }

    var mainNavigationStack: some View {
        NavigationStack {
            MainListView(
                text: $text,
                importance: $importance,
                deadline: $deadline,
                selectedImportanceIndex: $selectedImportanceIndex,
                switchIsOn: $switchIsOn,
                datePickerIsOn: $datePickerIsOn,
                todoItem: $todoItem,
                category: $category
            )
            .padding(.top, -20)
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
            .background(Resources.Colors.Back.primaryColor)
            .onAppear {
                loadTodoItem()
            }
        }
        .frame(minHeight: 112.5, maxHeight: .infinity, alignment: .top)
        .background(Resources.Colors.Back.primaryColor)
    }

    var saveButton: some View {
        Button {
            saveTodoItem()
        } label: {
            Text("Сохранить")
                .font(.system(size: 17))
                .fontWeight(.bold)
        }
    }

    var cancelButton: some View {
        Button {
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            Text("Отменить")
                .font(.system(size: 17))
        }
    }

    private func saveTodoItem() {
        switch selectedImportanceIndex {
        case 0:
            importance = .unimportant
        case 1:
            importance = .ordinary
        case 2:
            importance = .important
        default:
            importance = .ordinary
        }

        let updatedTodoItem = TodoItem(
            id: todoItem?.id ?? UUID().uuidString,
            text: text,
            importance: importance,
            deadline: deadline,
            isTaskDone: isTaskDone,
            creationDate: creationDate,
            modifiedDate: Date(),
            category: category
        )
        
        if currentFramework == .swiftUI {
            if todoItem != nil {
                viewModel.updateTodoItem(updatedTodoItem)
            } else {
                viewModel.addToDo(new: updatedTodoItem)
            }
        }
        
        todoItem = updatedTodoItem
        self.presentationMode.wrappedValue.dismiss()
    }

    private func loadTodoItem() {
        importance = todoItem?.importance ?? .ordinary
        switch importance {
        case .unimportant:
            selectedImportanceIndex = 0
        case .ordinary:
            selectedImportanceIndex = 1
        case .important:
            selectedImportanceIndex = 2
        }
        text = todoItem?.text ?? "Что надо сделать?"
        deadline = todoItem?.deadline ?? nil
        category = todoItem?.category ?? Category(categoryName: "Другое", categoryColor: .init(color: .clear))
        if deadline != nil {
            switchIsOn = true
        }
    }
}

struct AddToDoModalView_Previews: PreviewProvider {
    @State static var examleToDoItem: TodoItem? = TodoItem(text: "sdfgsdfg",
                                                    importance: .important,
                                                    deadline: Date(),
                                                    isTaskDone: true,
                                                    creationDate: Date(),
                                                    modifiedDate: nil)

    static var previews: some View {
        ToDoModalView(todoItem: $examleToDoItem, currentFramework: .swiftUI)
    }
}
