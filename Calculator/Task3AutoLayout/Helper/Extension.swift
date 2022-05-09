//
//  Extension.swift
//  Task3AutoLayout
//
//  Created by Tymofii (Work) on 25.09.2021.
//

import Foundation
import UIKit

extension Double {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}

extension UIFont {
    static func mainFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Apple SD Gothic Neo", size: size)!
    }
    static func someFont1(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Times New Roman", size: size)!
    }
    static func someFont2(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Arial", size: size)!
    }
}
