//
//  ToDoItemView.swift
//  ToDo
//
//  Created by Александр Андреев on 29.06.2024.
//

import Foundation
import SwiftUI
struct TodoItemView: View {
    
    @Binding var todoItem: TodoItem
    @State private var isShowingModal = false
    @EnvironmentObject var viewModel: MainViewModel
    
    var body: some View {
        HStack {
            checkboxButton
            titleText
            Spacer()
            arrowChangeButton
        }
        .frame(height: 50)
    }
    
    var checkboxButton: some View {
        Button(action: {
            todoItem.isTaskDone.toggle()
            viewModel.updateTodoItem(todoItem)
        }) {
            Image(systemName: imageName(forState: todoItem.isTaskDone))
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(color(forState: todoItem.isTaskDone))
                .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    
    var titleText: some View {
        Text(todoItem.text)
            .foregroundColor(todoItem.isTaskDone ? Resources.LightTheme.Label.TetiaryColor : Resources.LightTheme.Label.blackColor)
            .strikethrough(todoItem.isTaskDone)
            .padding(.leading, 8)

    }
    
    var arrowChangeButton: some View {
        Button(action: {
            self.isShowingModal = true
        }) {
            Image(Resources.LightTheme.Buttons.arrowButton)
                .contentShape(Rectangle())
        }
            .buttonStyle(PlainButtonStyle())
            .padding(.trailing, 8)
            .sheet(isPresented: $isShowingModal) {
                ToDoModalView(todoItem: Binding($todoItem))
            }
    }

    func imageName(forState isSelected: Bool) -> String {
        isSelected ? "checkmark.circle.fill" : "circle"
    }

    func color(forState isSelected: Bool) -> Color {
        isSelected ? Resources.LightTheme.greenColor : Resources.LightTheme.grayColor
    }
}
