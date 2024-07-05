//
//  ContentView.swift
//  ToDo
//
//  Created by Александр Андреев on 17.06.2024.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject var viewModel = MainViewModel()
    @State private var editingTodoItem: TodoItem? = nil
    @State private var isShowingModal = false
    @State private var buttonTitle = "Скрыть"
    
    @State private var isSettingsViewPresented = false

    
    var body: some View {
        
            NavigationView {
                
                ZStack {
                    NavigationSplitView {
                        ListView(viewModel: viewModel, editingTodoItem: $editingTodoItem, isShowingModal: $isShowingModal, buttonTitle: $buttonTitle)
                            .environmentObject(viewModel)
                            .navigationTitle("Мои дела")
                            .background(colorScheme == .light
                                ? Resources.LightTheme.Back.primaryColor
                                : Resources.DarkTheme.Back.primaryColor
                            )
                            .toolbar {
                                ToolbarItem(placement: .navigationBarTrailing) {
                                    NavigationLink(destination: SettingsViewControllerRepresentable().navigationBarHidden(true)
                                        .background(colorScheme == .light
                                            ? Resources.LightTheme.Back.primaryColor
                                            : Resources.DarkTheme.Back.primaryColor
                                        ), isActive: $isSettingsViewPresented){
                                        settingsButton
                                    }
                                    
                                }
                                ToolbarItem(placement: .navigationBarTrailing) {
                                    NavigationLink(destination: CalendarViewControllerRepresentable(items: $viewModel.todosArray)
                                        .environmentObject(viewModel)
                                        .navigationBarHidden(true)
                                            .background(colorScheme == .light
                                                ? Resources.LightTheme.Back.primaryColor
                                                : Resources.DarkTheme.Back.primaryColor
                                            )
                                        ) {
                                                calendarButton
                                        }
                
                                }
                                
                            }
                    } detail: {
                        EmptyView()
                    }
                    .background(colorScheme == .light
                        ? Resources.LightTheme.Back.primaryColor
                        : Resources.DarkTheme.Back.primaryColor
                    )
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    if !isSettingsViewPresented {
                        VStack {
                            Spacer()
                            addButton
                                .padding(.bottom, 54)
                        }
                    }

                }
                .background(colorScheme == .light
                    ? Resources.LightTheme.Back.primaryColor
                    : Resources.DarkTheme.Back.primaryColor
                )
            }
        }
    
    var calendarButton: some View {
        Image(systemName: "calendar")
            .foregroundStyle(.blue)
    }
    
    var settingsButton: some View {
        Image(systemName: "gearshape")
            .foregroundStyle(.blue)
    }
    
    var addButton: some View {
        Button {
            self.editingTodoItem = nil
            self.isShowingModal = true
        } label: {
            Image(systemName: "plus.circle.fill")
                .resizable()
                .frame(width: 44, height: 44)
                .shadow(radius: 5)
        }
        .padding(.bottom, 15)
        .sheet(isPresented: $isShowingModal, onDismiss: {
            if let newItem = editingTodoItem {
                viewModel.addToDo(new: newItem)
            }
        }) {
            ToDoModalView(todoItem: $editingTodoItem, currentFramework: .swiftUI)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
