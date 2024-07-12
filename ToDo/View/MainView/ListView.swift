//
//  ListView.swift
//  ToDo
//
//  Created by Александр Андреев on 29.06.2024.
//

import Foundation
import SwiftUI

struct ListView: View {
//    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var viewModel: MainViewModel
    @Binding var editingTodoItem: TodoItem?
    @Binding var isShowingModal: Bool
    @Binding var buttonTitle: String
    @State private var newItemText: String = ""
    
    var body: some View {
        List {
            Section {
                ForEach($viewModel.todosArray) { $item in
                    // ячейка
                    TodoItemView(todoItem: $item)
                        .frame(height: 50)
                        .background(Resources.Colors.Back.secondaryColor)
                        .listRowInsets(.init(top: 16, leading: 16, bottom: 16, trailing: 0))
                }
                // новое
                NewToDoItemView(text: "") { text in
                    viewModel.addToDo(new: TodoItem(text: text, 
                                                    importance: .ordinary,
                                                    deadline: nil,
                                                    isTaskDone: false,
                                                    creationDate: Date(),
                                                    modifiedDate: nil))
                }
                    .frame(height: 50)
                    .listRowInsets(.init(top: 16, leading: 16, bottom: 16, trailing: 0))
            // ListHeaderView - Выполнено - 5    Показать
            } header: {
                ListHeaderView(viewModel: viewModel, buttonTitle: $buttonTitle)
                    .padding(.bottom, 15)
                    .padding(.top, -15)
            }
            .listRowBackground(Resources.Colors.Back.secondaryColor)
            .listRowInsets(.init(top: 0, leading: 8, bottom: 0, trailing: 8))
            .listRowSeparatorTint(Resources.Colors.Support.separatorColor)
        }
        .listStyle(PlainListStyle())
        .background(Resources.Colors.Back.primaryColor)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    var newItemEditor: some View {
        ZStack(alignment: .leading) {
            if newItemText.isEmpty {
                Text("Новое")
                    .foregroundColor(Resources.Colors.Label.TetiaryColor)
                    .padding(.leading, 50)
            }
            TextEditor(text: $newItemText)
                .foregroundColor(Resources.Colors.Label.primaryColor)
                .background(Resources.Colors.Back.primaryColor)
                .onTapGesture {
                    if newItemText == "Новое" {
                        newItemText = ""
                    }
                }
                .padding(.leading, 39)
        }
    }
    
}
