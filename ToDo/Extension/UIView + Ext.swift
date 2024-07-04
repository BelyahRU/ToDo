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
    }
    
    func makeBordersColor(color: CGColor) {
        self.layer.borderColor = color
    }
    
//    func addTopBorderWithColor(color: UIColor, width: CGFloat) {
//        let border = CALayer()
//        border.backgroundColor = color.cgColor
//        border.frame = CGRect(x: 0, y: 0, width: self.contentSize, height: width)
//        self.layer.addSublayer(border)
//    }
//    
//    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
//        let border = CALayer()
//        border.backgroundColor = color.cgColor
//        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
//        self.layer.addSublayer(border)
//    }
}

