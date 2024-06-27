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
    
    var body: some View {
        VStack(spacing: 20) {
            headHStack
            mainVStack
                .padding(.top, 15)
            Spacer()
        }
        .background(Resources.LightTheme.Back.primaryColor)
    }
    
    var headHStack: some View {
        HStack {
            cancelButton
            Spacer()
            deloText
            Spacer()
            saveButton
        }
        .frame(height: 56)
        .padding(.top, 0)
    }
    
    var cancelButton: some View {
        Button {
            print("Отменить")
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            Text("Отменить")
                .font(.system(size: 17))
        }
        .frame(width: 105)
        .frame(height: 56)
    
    }
    
    var deloText: some View {
        Text("Дело")
            .font(.system(size: 17))
            
    }
    
    var saveButton: some View {
        Button {
            print("save")
        } label: {
            Text("Сохранить")
                .font(.system(size: 17))
                .fontWeight(.bold)
        }
        .frame(width: 105)
        .frame(height: 56)

    }
    
    var mainVStack: some View {
        VStack {
            whatToDoTextView
            Spacer()
            list
            removeButton
            Spacer()
        }
        .frame(height: 352.5)
        .padding(.leading, 15)
        .padding(.trailing, 15)

    }
    
    var whatToDoTextView: some View {
        Text("asdgas")
            .frame(minWidth: 343, minHeight: 120)
            .background(.black)
    }
    
    var list: some View {
        List {
            importanceHStack
            deadlineHStack
        }
        .cornerRadius(16)
        .frame(minWidth: 343)
        .listStyle(PlainListStyle())
    }
    
    var importanceHStack: some View {
        HStack {
            
        }
    }
    
    var deadlineHStack: some View {
        HStack {
            
        }
    }
    
    var removeButton: some View {
        Button {
            print("sfdgsef")
        } label: {
            Text("Удалить")
                .foregroundColor(Resources.LightTheme.redColor)
            
        }
        .frame(height: 56)
        .frame(minWidth: 343)
        .background(Resources.LightTheme.whiteColor)
        .cornerRadius(16)

    }
    
}

struct AddToDoModalView_Previews: PreviewProvider {
    @State static var examleToDoItem: TodoItem? = TodoItem(text: "sdfgsdfg", importance: .important, deadline: Date(), isTaskDone: true, creationDate: Date(), modifiedDate: nil)
    static var previews: some View {
        ToDoModalView(todoItem: $examleToDoItem)
    }
}
