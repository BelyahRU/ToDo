//
//  Binding + Ext.swift
//  ToDo
//
//  Created by Александр Андреев on 29.06.2024.
//

import Foundation
import SwiftUI
extension Binding {
    init(_ base: Binding<Value>) {
        self.init(
            get: { base.wrappedValue },
            set: { newValue in base.wrappedValue = newValue }
        )
    }
}
