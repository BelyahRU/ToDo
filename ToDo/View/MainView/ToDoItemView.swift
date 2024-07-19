//
//  ToDoItemView.swift
//  ToDo
//
//  Created by Александр Андреев on 29.06.2024.
//

import Foundation
import SwiftUI
struct TodoItemView: View {
    @Environment(\.colorScheme) 
    var colorScheme
    @Binding var todoItem: TodoItem
    @State private var isShowingModal = false
    @EnvironmentObject var viewModel: MainViewModel    
    var body: some View {
        HStack {
            checkboxButton
            if todoItem.deadline != nil {
                VStack(alignment: .leading) {
                    titleText
                    deadlineText
                        .padding(.leading, 5)
                }
            } else {
                titleText
            }
            Spacer()
            arrowChangeButton
        }
        .frame(height: 50)
    }
    
    var deadlineText: some View {
        HStack(spacing: 4) {
            Image(colorScheme == .light ?
                  Resources.LightTheme.Images.lightCalendar
                  : Resources.LightTheme.Images.darkCalendar)
            Text("\(todoItem.deadline!.getDayMonthFormatted())")
                .foregroundColor(Resources.Colors.Label.TetiaryColor)
                .font(.system(size: 15))
        }
    }
    
    var checkboxButton: some View {
        Button {
            todoItem.isTaskDone.toggle()
            viewModel.updateTodoItem(todoItem)
        } label: {
            Image(systemName: imageName(forState: todoItem.isTaskDone))
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(color(forState: todoItem.isTaskDone, importance: todoItem.importance))
                .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())

//        Button(action: {
//            todoItem.isTaskDone.toggle()
//            viewModel.updateTodoItem(todoItem)
//        } ) {
//            Image(systemName: imageName(forState: todoItem.isTaskDone))
//                .resizable()
//                .frame(width: 30, height: 30)
//                .foregroundColor(color(forState: todoItem.isTaskDone, importance: todoItem.importance))
//                .contentShape(Rectangle())
//        }
//        .buttonStyle(PlainButtonStyle())
    }

    var titleText: some View {
        HStack(spacing: 0) {
            if todoItem.importance == .important {
                Image(Resources.LightTheme.Images.exclamationMark)
            }
            Text(todoItem.text)
                .foregroundColor(todoItem.isTaskDone 
                                 ? Resources.Colors.Label.TetiaryColor
                                 : Resources.Colors.Label.primaryColor)
                .strikethrough(todoItem.isTaskDone)
                .padding(.leading, 8)
        }
    }
    
    var arrowChangeButton: some View {
        Button {
            self.isShowingModal = true
        } label: {
            Image(Resources.LightTheme.Buttons.arrowButton)
                .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
        .padding(.trailing, 8)
        .sheet(isPresented: $isShowingModal) {
            ToDoModalView(todoItem: Binding($todoItem), currentFramework: .swiftUI)
        }
    }

    func imageName(forState isSelected: Bool) -> String {
        isSelected ? "checkmark.circle.fill" : "circle"
    }

    func color(forState isSelected: Bool, importance: Importance) -> Color {
        switch importance {
        case .unimportant:
            return isSelected ? Resources.Colors.greenColor : Resources.Colors.grayColor
        case .ordinary:
            return isSelected ? Resources.Colors.greenColor : Resources.Colors.grayColor
        case .important:
            return isSelected ? Resources.Colors.greenColor : Resources.Colors.redColor
        }
    }
}
