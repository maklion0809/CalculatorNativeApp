//
//  NumberButton.swift
//  Task3AutoLayout
//
//  Created by Tymofii (Work) on 25.09.2021.
//

import UIKit

final class CalculatorButtonMain: UIButton {
    
    var operatorType: ButtonTypeMain = .one {
        didSet {
            switch operatorType {
            case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .common:
                backgroundColor = .darkGray
                titleLabel?.textColor = .white
            case .percent, .changeSign, .clear:
                backgroundColor = .systemGray2
                tintColor = .black
                titleLabel?.textColor = .black
            case .plus, .subtract, .multiply, .divide, .equals:
                backgroundColor = .orange
                tintColor = .white
            }
        }
    }
    
    var isTouching = false {
        didSet {
            switch operatorType {
            case .divide, .multiply, .plus, .subtract:
                if isTouching {
                    backgroundColor = .white
                    tintColor = .orange
                } else {
                    backgroundColor = .orange
                    tintColor = .white
                }
            case .percent:
                if isTouching {
                    backgroundColor = .white
                    tintColor = .systemGray2
                } else {
                    backgroundColor = .systemGray2
                    tintColor = .black
                }
            default: break
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height * 0.5
    }
    
}

enum ButtonTypeMain: CaseIterable {
    case clear, changeSign, percent, divide
    case seven, eight, nine, multiply
    case four, five, six, subtract
    case one, two, three, plus
    case zero, common, equals
    
    func text() -> String? {
        switch self {
        case .zero:
            return "0"
        case .one:
            return "1"
        case .two:
            return "2"
        case .three:
            return "3"
        case .four:
            return "4"
        case .five:
            return "5"
        case .six:
            return "6"
        case .seven:
            return "7"
        case .eight:
            return "8"
        case .nine:
            return "9"
        case .clear:
            return "C"
        case .common:
            return "."
        default:
            return nil
        }
    }
    
    func systemImage() -> String? {
        switch self {
        case .plus:
            return "plus"
        case .subtract:
            return "minus"
        case .multiply:
            return "multiply"
        case .divide:
            return "divide"
        case .equals:
            return "equal"
        case .percent:
            return "percent"
        case .changeSign:
            return "plus.slash.minus"
        default:
            return nil
        }
    }
    
    func execute(_ first: Double, _ second: Double) -> String? {
        switch self {
        case .plus:
            return "\((first + second).clean)"
        case .subtract:
            return "\((first - second).clean)"
        case .multiply:
            return "\((first * second).clean)"
        case .divide:
            return "\((first / second).clean)"
        case .percent:
            return "\((first / 100 * second).clean)"
        default:
            return nil
        }
    }
}
