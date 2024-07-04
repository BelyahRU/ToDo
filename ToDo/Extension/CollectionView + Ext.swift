//
//  CollectionView + Ext.swift
//  ToDo
//
//  Created by Александр Андреев on 03.07.2024.
//

import Foundation
import UIKit
extension UICollectionView {
    func addTopBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: self.contentSize.width, height: width)
        self.layer.addSublayer(border)
    }
    
    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.contentSize.width, height: width)
        self.layer.addSublayer(border)
    }
}
