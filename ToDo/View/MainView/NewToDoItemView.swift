//
//  NewToDoItemView.swift
//  ToDo
//
//  Created by Александр Андреев on 29.06.2024.
//

import Foundation
import SwiftUI

struct NewToDoItemView: View {
//    @Environment(\.colorScheme) var colorScheme
    
    @State var text: String
    var closureItem: (String) -> Void
    
    
    var body: some View {
            TextField("Новое", text: $text)
                .frame(height: 56)
                .font(.subheadline)
                .foregroundColor(Resources.Colors.Label.primaryColor)
                .onSubmit {
                    closureItem(text)
                    text = ""
                }
    }
}
