//
//  SpecialButton.swift
//  Task3AutoLayout
//
//  Created by Tymofii (Work) on 25.09.2021.
//

import UIKit

class CalculatorButtonSpecial: UIButton {
    var operatorType: ButtonTypeSpecial = .rand {
        didSet {
            backgroundColor = #colorLiteral(red: 0.1038954984, green: 0.1119295497, blue: 0.123171069, alpha: 1)
            tintColor = .white
        }
    }
    var isTouching: Bool = false {
        didSet {
            if isTouching {
                backgroundColor = .white
                titleLabel?.textColor = .black
            } else {
                backgroundColor = #colorLiteral(red: 0.1038954984, green: 0.1119295497, blue: 0.123171069, alpha: 1)
                titleLabel?.textColor = .white
            }
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.size.height * 0.5
    }
}


enum ButtonTypeSpecial: CaseIterable {
    case rightParenthesis, leftParenthesis, mc, mPlus, mMinus, mr
    case twoND, xSquared, xСubed, xInY, expInX, tenInX
    case oneDividedByX, squareRoot, cubicRoot, rootOfY, ln, logTen
    case xFactorial, sinx, cosx, tanx, expan, eE
    case deg, sinhx, coshx, tanhx, pi, rand
    
    func text() -> String {
        switch self {
        case .rightParenthesis:
            return "("
        case .leftParenthesis:
            return ")"
        case .mc:
            return "mc"
        case .mPlus:
            return "m+"
        case .mMinus:
            return "m-"
        case .mr:
            return "mr"
        case .twoND:
            return "2nd"
        case .xSquared:
            return "x\u{00B2}"
        case .xСubed:
            return "x\u{00B3}"
        case .xInY:
            return "x^y"
        case .expInX:
            return "e"
        case .tenInX:
            return "10^x"
        case .oneDividedByX:
            return "1/x"
        case .squareRoot:
            return "\u{221A}x"
        case .cubicRoot:
            return "\u{221B}x"
        case .rootOfY:
            return "y\u{221A}x"
        case .ln:
            return "ln"
        case .logTen:
            return "lg"
        case .xFactorial:
            return "x!"
        case .sinx:
            return "sin"
        case .cosx:
            return "cos"
        case .tanx:
            return "tan"
        case .expan:
            return "e"
        case .eE:
            return "EE"
        case .deg:
            return "Deg"
        case .sinhx:
            return "sinh"
        case .coshx:
            return "cosh"
        case .tanhx:
            return "tanh"
        case .pi:
            return "π"
        case .rand:
            return "Rand"
        }
    }
    
    func execute(_ number: Double) -> Double? {
        switch self {
        case .xSquared:
            return pow(number, 2)
        case .xСubed:
            return pow(number, 3)
        case .expInX:
            return pow(2.7, number)
        case .tenInX:
            return pow(10, number)
        case .oneDividedByX:
            return 1 / number
        case .squareRoot:
            return sqrt(number)
        case .cubicRoot:
            return pow(number, 1 / 3)
        case .xFactorial:
            return Double(factorial(Int(number)))
        case .sinx:
            return sin(number)
        case .cosx:
            return cos(number)
        case .tanx:
            return tan(number)
        case .expan:
            return exp(number)
        case .sinhx:
            return sinh(number)
        case .coshx:
            return cosh(number)
        case .tanhx:
            return tanh(number)
        case .pi:
            return Double.pi
        case .rand:
            return Double.random(in: 0...1)
        default:
            return nil
        }
        
    }
}
