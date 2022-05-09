//
//  MathFunction.swift
//  Task3AutoLayout
//
//  Created by Tymofii (Work) on 25.09.2021.
//

import Foundation

func factorial(_ x: Int) -> Int {
    if x < 1 {
        return 1
    }
    return x * factorial(x-1)
}
