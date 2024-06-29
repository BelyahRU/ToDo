//
//  MainList.swift
//  ToDo
//
//  Created by Александр Андреев on 29.06.2024.
//

import Foundation
import SwiftUI

struct MainListView: View {
    @Binding var text: String
    @Binding var importance: Importance
    @Binding var deadline: Date?
    @Binding var selectedImportanceIndex: Int
    @Binding var switchIsOn: Bool
    @Binding var datePickerIsOn: Bool
    @Binding var todoItem: TodoItem?
    @EnvironmentObject var viewModel: MainViewModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        List {
            Section {
                textEditor
            }
            Section {
                importanceHStack
                deadlineHStack
                
                if datePickerIsOn {
                    datePicker
                }
            }
            Section {
                removeButton
            }
        }
        .listSectionSpacing(16)
        .listStyle(.insetGrouped)
        .listRowBackground(Resources.LightTheme.Back.primaryColor)
        .frame(minHeight: 112.5)
    }

    var textEditor: some View {
        TextEditor(text: $text)
            .frame(minHeight: 120)
            .background(Color.white)
            .foregroundColor(.black)
            .cornerRadius(16)
    }
    
    var importanceHStack: some View {
        HStack {
            Text("Важность")
                .font(.system(size: 17))
                .foregroundColor(Resources.LightTheme.Label.blackColor)
            Spacer()
            
            Picker("importance", selection: $selectedImportanceIndex) {
                Image(systemName: "arrow.down").tag(0)
                Text("нет").tag(1)
                Image(Resources.LightTheme.Images.exclamationMark).tag(2)
            }
            .pickerStyle(SegmentedPickerStyle())
            .frame(width: 150)
            .accentColor(.red)
        }
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
                if newValue {
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
                    datePickerIsOn = false
                }
            ),
            displayedComponents: [.date]
        )
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
}
