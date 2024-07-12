//
//  ListHeaderView.swift
//  ToDo
//
//  Created by Александр Андреев on 29.06.2024.
//

import Foundation
import SwiftUI

struct ListHeaderView: View {
    @ObservedObject var viewModel: MainViewModel
    @Binding var buttonTitle: String
//    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack {
            completedText
            Spacer()
            showButton
        }
        .background(Resources.Colors.Back.primaryColor)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 18)
    }
    
    var completedText: some View {
        Text("Выполнено - \(viewModel.countItemsAreDone)")
            .foregroundColor(Resources.Colors.Label.TetiaryColor)
            .font(.system(size: 15))
    }
    
    var showButton: some View {
        Button(buttonTitle) {
            toggleButtonTitle()
            if viewModel.contentFilter == ContentFilter.allItems {
                viewModel.contentFilter = .onlyNotCompletedItems
            } else {
                viewModel.contentFilter = ContentFilter.allItems
            }
        }
        .foregroundColor(Resources.Colors.blueColor)
        .font(.system(size: 15))
        .bold()
    }
    
    private func toggleButtonTitle() {
        buttonTitle = (buttonTitle == "Показать") ? "Скрыть" : "Показать"
    }
}
