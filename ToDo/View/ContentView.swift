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
    @State private var editingTodoItem: TodoItem? = nil
    
    @State private var isShowingModal = false
    
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
        
        .environmentObject(viewModel)
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
                        .background(Color.white)
                        .listRowBackground(Color.white)
                }
                .background(Color.white)
                .listRowBackground(Color.white)
//                .listSectionSpacing(16)
                // Последняя ячейка без чекбокса
                lastItem
                    .frame(height: 50)
                    .background(Color.white)
                    .listRowBackground(Color.white)
            }
            .cornerRadius(16)
            .listStyle(PlainListStyle())
            .background(Resources.LightTheme.Back.primaryColor)
        }
        .padding(.leading, 16)
        .padding(.trailing, 16)
        .background(Resources.LightTheme.Back.primaryColor)
        .cornerRadius(16)
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
        Text("Выполнено - \(viewModel.countItemsAreDone)")
            .foregroundColor(.black.opacity(0.3))
            .font(.system(size: 15))
    }
    
    var showButton: some View {
        Button("Показать"){
            if viewModel.contentFilter == ContentFilter.allItems {
                viewModel.contentFilter = .onlyNotCompletedItems
            } else {
                viewModel.contentFilter = ContentFilter.allItems
            }
        }
            .foregroundColor(Resources.LightTheme.blueColor)
            .font(.system(size: 15))
            .bold()
    }
    
    var addButton: some View {
        Button {
            self.editingTodoItem = nil 
            self.isShowingModal = true
            
        } label: {
            Image(systemName: "plus.circle.fill")
                .resizable()
                .frame(width: 44, height: 44)
        }
            .padding(.bottom, 15)
            .sheet(isPresented: $isShowingModal, onDismiss: {
                if let newItem = editingTodoItem {
                    viewModel.addToDo(new: newItem)
                }
            }) {
                ToDoModalView(todoItem: $editingTodoItem)
            }
            
    }
    
}



extension Binding {
    init(_ base: Binding<Value>) {
        self.init(
            get: { base.wrappedValue },
            set: { newValue in base.wrappedValue = newValue }
        )
    }
}






struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
//        TestView()
    }
}
