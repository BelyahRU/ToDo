//
//  ContentView.swift
//  ToDo
//
//  Created by Александр Андреев on 17.06.2024.
//

import SwiftUI

struct ContentView: View {
    
    //StateObject используется для создания и управления состоянием внутри "View".
    //это позволяет SwiftUi отслеживать изменения
    //в объекте и обновлять представление, когда эти изменения происходят
    //Здесь @StateObject var viewModel создает экземпляр
    //MainViewModel и управляет его состоянием.
    //Когда свойства @Published в MainViewModel изменяются,
    //представление автоматически обновляется.
    @StateObject var viewModel = MainViewModel()
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                mainVStack
                plansList
            }
                .background(Resources.LightTheme.Back.primaryColor)
            VStack {
                Spacer()
                addButton
                    .padding(.bottom, 54)
            }
        }
        
    
    }
    
    var mainVStack: some View {
        VStack(alignment: .leading) {
            myPlansText
            completedAndShowHStack
            
        }
            .padding(.leading, 32)
            .padding(.trailing, 32)
            .padding(.top, 44)
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .background(Resources.LightTheme.Back.primaryColor)
    }
    
    var completedAndShowHStack: some View {
        HStack {
            completedText
            Spacer()
            showButton
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 18)
    }
    
    var plansList: some View {
        NavigationView {
            List {
                ForEach($viewModel.todosArray) { $item in
                    TodoItemView(todoItem: $item)
                        .frame(height: 50)
                }
                // Последняя ячейка без чекбокса
                lastItem
                    .frame(height: 50)
            }
            .cornerRadius(16)
            .listStyle(PlainListStyle())
            
            .background(Resources.LightTheme.Back.primaryColor)
        }
        .padding(.leading, 16)
        .padding(.trailing, 16)
        .background(Resources.LightTheme.Back.primaryColor)
        
    }
    
    var lastItem: some View {
            HStack {
                Text("Новое")
                    .foregroundColor(Resources.LightTheme.Label.TetiaryColor)
                    .padding(.leading, 39)
                Spacer()
            }
            
        }
    
    var myPlansText: some View {
        Text("Мои дела")
            .bold()
            .foregroundColor(Resources.LightTheme.Label.blackColor)
            .background(Color.clear)
            .font(.system(size: 34))
            .frame(height: 41)
    }
    
    var completedText: some View {
        Text("Выполнено - \(viewModel.getToDosArray().filter{$0.isTaskDone == true}.count)")
            .foregroundColor(.black.opacity(0.3))
            .font(.system(size: 15))
    }
    
    var showButton: some View {
        Button("Показать"){}
            .foregroundColor(Resources.LightTheme.blueColor)
            .font(.system(size: 15))
            .bold()
    }
    
    var addButton: some View {
        Button {
            print("add pressed")
        } label: {
            Image(systemName: "plus.circle.fill")
                .resizable()
                .frame(width: 44, height: 44)
        }
            .padding(.bottom, 15)
            
    }
    
}
//
struct iOSCheckboxToggleStyle: ToggleStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        // 1
        Button(action: {
            configuration.isOn.toggle()
        }, label: {
            HStack {
                // 3
                Image(systemName: imageName(forState: configuration.isOn))
                    .resizable()
                    .foregroundColor(color(forState: configuration.isOn))
                    .frame(width: 30, height: 30)
                configuration.label
            }
        }
        )
    }
    
    func imageName(forState isSelected: Bool) -> String {
        isSelected ? "checkmark.circle.fill" : "circle"
    }
    
    func color(forState isSelected: Bool) -> Color {
        isSelected ? Resources.LightTheme.greenColor : Resources.LightTheme.grayColor
        
    }
    
//
//        Toggle("", isOn: $todoItem.isTaskDone)
//            .labelsHidden()
//            .toggleStyle(iOSCheckboxToggleStyle())
}

struct TodoItemView: View {
    @Binding var todoItem: TodoItem

    var body: some View {
        HStack {
            Button(action: {
                print("Checkbox tapped")
                todoItem.isTaskDone.toggle()
            }) {
                Image(systemName: imageName(forState: todoItem.isTaskDone))
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(color(forState: todoItem.isTaskDone))
                    .contentShape(Rectangle()) // Ensure the entire frame is tappable
            }
            .buttonStyle(PlainButtonStyle())

            Text(todoItem.text)
                .foregroundColor(todoItem.isTaskDone ? Resources.LightTheme.Label.TetiaryColor : Resources.LightTheme.Label.blackColor)
                .strikethrough(todoItem.isTaskDone)
                .padding(.leading, 8)

            Spacer()

            Button(action: {
                print("Arrow button tapped")
            }) {
                Image(Resources.LightTheme.Buttons.arrowButton)
                    .contentShape(Rectangle()) // Ensure the entire frame is tappable
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.trailing, 8) // Add padding to avoid overlap
        }
        .frame(height: 50) // Define a fixed height to avoid overlapping issues
    }

    func imageName(forState isSelected: Bool) -> String {
        isSelected ? "checkmark.circle.fill" : "circle"
    }

    func color(forState isSelected: Bool) -> Color {
        isSelected ? Resources.LightTheme.greenColor : Resources.LightTheme.grayColor
    }
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
//        TestView()
    }
}
