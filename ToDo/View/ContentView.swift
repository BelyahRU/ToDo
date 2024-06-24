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
        VStack(spacing: 20) {
            mainVStack
            plansList
        }
        .background(Resources.LightTheme.Back.primaryColor)
    
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
                        .frame(height: 56)
                }
                // Последняя ячейка без чекбокса
                lastItem
                    .frame(height: 56)
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
        Text("Выполнено - 5")
            .foregroundColor(.black.opacity(0.3))
            .font(.system(size: 15))
    }
    
    var showButton: some View {
        Button("Показать") {}
            .foregroundColor(Resources.LightTheme.blueColor)
            .font(.system(size: 15))
            .bold()
    }
    
}

struct iOSCheckboxToggleStyle: ToggleStyle {
    
    var checkmarkIsOn: some View {
        Image(systemName: "checkmark.circle.fill")
            .foregroundColor(Resources.LightTheme.greenColor)
    }
    
    var checkmarkIsOff: some View {
        Image(systemName: "circle")
            .foregroundColor(Resources.LightTheme.grayColor)
    }
    
    func makeBody(configuration: Configuration) -> some View {
        // 1
        Button(action: {
            configuration.isOn.toggle()
        }, label: {
            HStack {
                // 3
                if configuration.isOn {
                    checkmarkIsOn
                } else {
                    checkmarkIsOff
                }
                
                configuration.label
            }
        }
        )
        .frame(width: 30, height: 30)
    }
}

struct TodoItemView: View {
    //Binding создаёт двухстороннюю привязку к данным. Это позволяет передавать данные из одного View в другой и позволяет дочернему View изменять данные, которые пренадлежат родительскому View
    //Здесь @Binding var todoItem: TodoItem позволяет передавать каждый элемент
    //задачи в TodoItemView как привязку.
    //Когда состояние задачи изменяется в дочернем
    @Binding var todoItem: TodoItem
    
    var body: some View {
        HStack {
            Toggle("", isOn: $todoItem.isTaskDone)
                .labelsHidden()
                .toggleStyle(iOSCheckboxToggleStyle())
            Text(todoItem.text)
                .foregroundColor(todoItem.isTaskDone ? .gray : .primary)
        }
        
        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
//        TestView()
    }
}
