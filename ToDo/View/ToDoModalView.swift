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
    @EnvironmentObject var viewModel: MainViewModel
    //listRowInsets
    @State private var text: String = ""
    @State private var importance: Importance = .unimportant
    @State private var deadline: Date? = nil
    @State private var isTaskDone: Bool = false
    @State private var creationDate: Date = Date()
    @State private var modifiedDate: Date? = nil
    
    
    @State private var selectedImportanceIndex = 0
    @State private var switchIsOn: Bool = false
    
    @State private var datePickerIsOn: Bool = false
    

    var body: some View {
        mainNavigationStack
    }
    
    var mainNavigationStack: some View {
        NavigationStack {
            mainList
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
            .onAppear {
                importance = todoItem?.importance ?? .ordinary
                switch importance {
                case .unimportant:
                    selectedImportanceIndex = 0
                case .ordinary:
                    selectedImportanceIndex = 1
                case .important:
                    selectedImportanceIndex = 2
                }
                text = todoItem?.text ?? ""
                deadline = todoItem?.deadline ?? nil
                if deadline != nil {
                    switchIsOn = true
                }

            }
        }
        .background(Resources.LightTheme.Back.primaryColor)
    }
    
    
    var textEditor: some View {
        ZStack {
//            if text.isEmpty {
//                Text("Что надо сделать?")
//                    .foregroundColor(.white)
//            }
            TextEditor(text: $text)
                .frame(minHeight: 120)
                .background(Color.white) // ?
                .foregroundColor(.black)
                .cornerRadius(16)
                .padding(.horizontal)
        }
    }
    
    var saveButton: some View {
        Button {
            print("save")
            saveTodoItem()
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
    
    var mainList: some View {
        List {
            Section {
                textEditor
            }
            Section {
                importanceHStack
                deadlineHStack
                if datePickerIsOn {
                    Divider().background(Color.gray.opacity(0.5))
                    datePicker
                }
            }
            Section {
                removeButton
            }
        }
//        .listSectionSpacing(16)
            .listStyle(.insetGrouped)
            .listRowBackground(Resources.LightTheme.Back.primaryColor)
            .frame(minHeight: 112.5)
    }
    
    var importanceHStack: some View {
        HStack {
            Text("Важность")
                .font(.system(size: 17))
                .foregroundColor(Resources.LightTheme.Label.blackColor)
            Spacer()
            
            Picker("importance", selection: $selectedImportanceIndex, content: {
                
                Image(systemName: "arrow.down").tag(0)
                Text("нет").tag(1)
                Text("!!").tag(2)
            })
            .pickerStyle(SegmentedPickerStyle())
            .frame(width: 150)
            .accentColor(.red)
        }
    }
    
    var unImportantImage: some View {
        Image(systemName: "arrow.down")
            .foregroundColor(Resources.LightTheme.Label.blackColor)
    }

    var deadlineHStack: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Сделать до")
                    .font(.system(size: 17))
                    .foregroundColor(Resources.LightTheme.Label.blackColor)
                if switchIsOn && deadline != nil {
                    Text("\(deadline!.formattedDate())")
                        .bold()
                        .font(.system(size: 13))
                        .foregroundColor(Resources.LightTheme.blueColor)
                        .onTapGesture {
                            datePickerIsOn.toggle()
                        }
                }
            }
            Spacer()
            Toggle(isOn: $switchIsOn.animation()) {
                EmptyView()
            }
                .labelsHidden()
                .onChange(of: switchIsOn) { newValue in
                    if newValue  {
                        if deadline == nil {
                            datePickerIsOn = true
                        }
                    } else {
                        deadline = nil
                        datePickerIsOn = false
                    }
                }
        }
    }
    
    var datePicker: some View {
        DatePicker(
            "",
            selection: Binding(
                get: { deadline ?? Date() },
                set: { newDate in
                    deadline = newDate
                    datePickerIsOn = false // Закрываем datePicker после выбора даты
                }
            ),
            displayedComponents: [.date]
        )
//        .colorMultiply(.black)
        .datePickerStyle(GraphicalDatePickerStyle())
        .labelsHidden()
        .padding(.horizontal)
        
    }


    var removeButton: some View {
        Button {
            viewModel.removeItem(item: todoItem)
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            Text("Удалить")
                .foregroundColor(Resources.LightTheme.redColor)
                .frame(minHeight: 56)
                .frame(minWidth: 343)

        }
        .background(Resources.LightTheme.blueColor)
        .cornerRadius(16)

    }
    
    private func saveTodoItem() {
        switch selectedImportanceIndex {
        case 0:
            importance = Importance.unimportant
        case 1:
            importance = Importance.ordinary
        case 2:
            importance = Importance.important
        default:
            importance = Importance.ordinary
        }
        
        let updatedTodoItem = TodoItem(id: todoItem?.id ?? UUID().uuidString,
                                       text: text,
                                       importance: importance,
                                       deadline: deadline,
                                       isTaskDone: isTaskDone,
                                       creationDate: creationDate,
                                       modifiedDate: Date())
        
        if let existingItem = todoItem {
            viewModel.updateTodoItem(updatedTodoItem)
        } else {
            viewModel.addToDo(new: updatedTodoItem)
        }
        
        self.presentationMode.wrappedValue.dismiss()
    }
}

    

struct AddToDoModalView_Previews: PreviewProvider {
    @State static var examleToDoItem: TodoItem? = TodoItem(text: "sdfgsdfg", importance: .important, deadline: Date(), isTaskDone: true, creationDate: Date(), modifiedDate: nil)
    static var previews: some View {
        ToDoModalView(todoItem: $examleToDoItem)
    }
}
