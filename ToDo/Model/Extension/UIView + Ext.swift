//
//  UIView + Ext.swift
//  ToDo
//
//  Created by Александр Андреев on 02.07.2024.
//

import Foundation
import UIKit
extension UIView {
    func makeRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
    }
    
    func makeBorders(width: CGFloat) {
        self.layer.borderWidth = width
        if self.traitCollection.userInterfaceStyle == .dark {
            self.layer.borderColor = UIColor(.white).cgColor
        } else {
            self.layer.borderColor = UIColor(.black).cgColor
        }
    }
    
    func makeBordersColor(color: CGColor) {
        self.layer.borderColor = color
    }
}

