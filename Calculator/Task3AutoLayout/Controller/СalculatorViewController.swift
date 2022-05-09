//
//  СalculatorViewController.swift
//  Task3AutoLayout
//
//  Created by Tymofii (Work) on 21.09.2021.
//

import UIKit

final class CalculatorViewController: UIViewController {
    
    // MARK: - Configuration
    
    private enum Configuration {
        static let mainItemWidth: CGFloat = 4
        static let mainItemHeight: CGFloat = 6
        static let specialItemWidth: CGFloat = 6
        static let specialItemRegularWidth: CGFloat = 10
        static let borderIndent: CGFloat = 10
        static let itemSpacing: CGFloat = 10
        static let mainStackItemsCount = 5
        static let specialStackItemsCount = 5
    }
    
    // MARK: - Variable
    
    private var operationSaved: CalculatorButtonMain?
    private var firstNumberSaved: Double?
    
    private var compactConstraints: [NSLayoutConstraint] = []
    private var regularConstraints: [NSLayoutConstraint] = []
    
    // MARK: - Main calculator
    
    private lazy var totalLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.text = "0"
        label.font = UIFont.mainFont(ofSize: sizeWidthButton(for: Configuration.mainItemWidth))
        
        return label
    }()
    
    private lazy var calculatorButtonMain: [CalculatorButtonMain] = {
        var buttons: [CalculatorButtonMain] = []
        for item in ButtonTypeMain.allCases {
            let button = CalculatorButtonMain()
            button.layer.cornerRadius = 0.5 * button.bounds.size.width
            button.clipsToBounds = true
            button.operatorType = item
            if let text = item.text() {
                button.setTitle(text, for: .normal)
            } else if let image = item.systemImage(){
                button.setImage(UIImage(systemName: image), for: .normal)
            }
            buttons.append(button)
        }
        
        return buttons
    }()
    
    private lazy var stackViewsHorizontalMain: [UIStackView] = {
        var stackViews: [UIStackView] = []
        for index in 0..<Configuration.mainStackItemsCount {
            let stackView = UIStackView()
            stackView.alignment = .fill
            stackView.axis = .horizontal
            stackView.distribution = .fillEqually
            stackView.spacing = Configuration.itemSpacing
            stackViews.append(stackView)
        }
        
        return stackViews
    }()
    
    private lazy var stackViewMain: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = Configuration.itemSpacing
        
        return stackView
    }()
    
    // MARK: - Special calculator
    
    private lazy var specialRadLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.mainFont(ofSize: sizeHeightButton(for: Configuration.mainItemHeight) / 2)
        
        return label
    }()
    
    private lazy var calculatorButtonSpecial: [CalculatorButtonSpecial] = {
        var buttons: [CalculatorButtonSpecial] = []
        for (index, item) in ButtonTypeSpecial.allCases.enumerated() {
            let button = CalculatorButtonSpecial()
            button.setTitle(item.text(), for: .normal)
            button.operatorType = item
            buttons.append(button)
        }
        return buttons
    }()
    
    private lazy var stackViewHorizontalSpecial: [UIStackView] = {
        var stackViews: [UIStackView] = []
        for index in 0..<Configuration.specialStackItemsCount {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.distribution = .fillEqually
            stackView.spacing = Configuration.itemSpacing
            stackViews.append(stackView)
        }
        
        return stackViews
    }()
    
    
    private lazy var specialStackViewMain: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.isHidden = true
        stackView.distribution = .fillEqually
        stackView.spacing = Configuration.itemSpacing
        
        return stackView
    }()
    
    // MARK: - Size counting functions
    
    private func sizeWidthButton(for count: CGFloat) -> CGFloat {
        (UIScreen.main.bounds.width - ((count + 1) * Configuration.itemSpacing)) / count
    }
    private func sizeHeightButton(for count: CGFloat) -> CGFloat {
        return (UIScreen.main.bounds.height - ((count + 1) * Configuration.itemSpacing)) / count
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubview()
        setupConstraints()
        layoutTrait(traitCollection: UIScreen.main.traitCollection)
    }
    
    // MARK: - Setting up the subview
    
    private func setupSubview() {
        
        // Setting up the main calculator
        
        var indexStackViewMain = 0
        for index in 1...ButtonTypeMain.allCases.count {
            stackViewsHorizontalMain[indexStackViewMain].addArrangedSubview(calculatorButtonMain[index - 1])
            if index % Int(Configuration.mainItemWidth) == 0 {
                indexStackViewMain += 1
            }
        }
        
        stackViewMain.translatesAutoresizingMaskIntoConstraints = false
        stackViewMain.addArrangedSubview(totalLabel)
        for stackView in stackViewsHorizontalMain {
            stackViewMain.addArrangedSubview(stackView)
        }
        
        view.addSubview(stackViewMain)
        
        for item in calculatorButtonMain {
            item.addTarget(self, action: #selector(actionMainOperation), for: .touchUpInside)
        }
        
        // Setting up the the special calculator
        
        var indexStackViewSpecial = 0
        for index in 1...ButtonTypeSpecial.allCases.count {
            stackViewHorizontalSpecial[indexStackViewSpecial].addArrangedSubview(calculatorButtonSpecial[index - 1])
            if index % Int(Configuration.specialItemWidth) == 0 {
                indexStackViewSpecial += 1
            }
        }
        
        specialStackViewMain.translatesAutoresizingMaskIntoConstraints = false
        specialStackViewMain.addArrangedSubview(specialRadLabel)
        for stackView in stackViewHorizontalSpecial {
            specialStackViewMain.addArrangedSubview(stackView)
        }
        
        view.addSubview(specialStackViewMain)
        
        for item in calculatorButtonSpecial {
            item.addTarget(self, action: #selector(actionSpecialOperation(sender:)), for: .touchUpInside)
        }
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        
        // Setting up the compact constraint
        
        compactConstraints.append(contentsOf: [
            stackViewMain.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Configuration.borderIndent),
            stackViewMain.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Configuration.borderIndent),
            stackViewMain.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Configuration.borderIndent)
        ])
        
        for button in calculatorButtonMain {
            compactConstraints.append(contentsOf: [
                button.widthAnchor.constraint(equalToConstant: sizeWidthButton(for: Configuration.mainItemWidth)),
                button.heightAnchor.constraint(equalToConstant: sizeWidthButton(for: Configuration.mainItemWidth)),
            ])
        }
        
        // Setting up the regular constraint
        
        regularConstraints.append(contentsOf: [
            specialStackViewMain.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Configuration.borderIndent),
            specialStackViewMain.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Configuration.borderIndent),
            specialStackViewMain.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Configuration.borderIndent),
            specialStackViewMain.trailingAnchor.constraint(equalTo: stackViewMain.leadingAnchor, constant: -Configuration.borderIndent),
            
            stackViewMain.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Configuration.borderIndent),
            stackViewMain.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Configuration.borderIndent),
            stackViewMain.leadingAnchor.constraint(equalTo: specialStackViewMain.trailingAnchor),
            stackViewMain.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Configuration.borderIndent)
        ])
        
        for button in (calculatorButtonSpecial + calculatorButtonMain) {
            regularConstraints.append(contentsOf: [
                button.widthAnchor.constraint(equalToConstant: sizeWidthButton(for: Configuration.specialItemRegularWidth / 2)),
                button.heightAnchor.constraint(equalToConstant: sizeHeightButton(for: Configuration.mainItemHeight))
            ])
        }
    }
    
    // MARK: - Size classes
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        
        super.traitCollectionDidChange(previousTraitCollection)
        
        layoutTrait(traitCollection: traitCollection)
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isPortrait {
            specialStackViewMain.isHidden = true
        } else {
            specialStackViewMain.isHidden = false
        }
        
    }
    
    private func layoutTrait(traitCollection: UITraitCollection) {
        if traitCollection.horizontalSizeClass == .compact && traitCollection.verticalSizeClass == .regular {
            if let regular = regularConstraints.first?.isActive {
                if regularConstraints.count > 0 && regular {
                    NSLayoutConstraint.deactivate(regularConstraints)
                }
            }
            // change size label
            totalLabel.font = UIFont.systemFont(ofSize: sizeWidthButton(for: Configuration.mainItemWidth))
            // activating compact constraints
            NSLayoutConstraint.activate(compactConstraints)
        } else {
            if let compact = compactConstraints.first?.isActive {
                if compactConstraints.count > 0 && compact {
                    NSLayoutConstraint.deactivate(compactConstraints)
                }
            }
            // change size label
            totalLabel.font = UIFont.systemFont(ofSize: sizeHeightButton(for: Configuration.mainItemHeight))
            specialRadLabel.font = UIFont.systemFont(ofSize: sizeHeightButton(for: Configuration.mainItemHeight) / 2)
            // activating regular constraints
            NSLayoutConstraint.activate(regularConstraints)
        }
    }
    
    // MARK: - Action subview main calculator
    
    @objc private func actionMainOperation(sender: CalculatorButtonMain) {
        
        switch sender.operatorType {
        case .clear:
            totalLabel.text = "0"
            firstNumberSaved = nil
            if let operation = operationSaved {
                operation.isTouching.toggle()
            }
            operationSaved = nil
        case .changeSign:
            if let number = Int(totalLabel.text ?? "0") {
                totalLabel.text = number < 0 ? "\(number * (-1))" : "\(-number)"
            }
        case .percent, .divide, .multiply, .plus, .subtract:
            if totalLabel.text != "0" || firstNumberSaved != nil {
                if let operation = operationSaved {
                    operation.isTouching.toggle()
                }
                operationSaved = sender
                sender.isTouching.toggle()
                if firstNumberSaved == nil {
                    firstNumberSaved = Double(totalLabel.text ?? "0")
                    totalLabel.text = "0"
                }
            }
        case .common where totalLabel.text == "0":
            totalLabel.text = (totalLabel.text ?? "") + "\(sender.operatorType.text() ?? "")"
        case .equals:
            if let firstNumber = firstNumberSaved,
               let secondNumber = Double(totalLabel.text ?? "0"),
               let operationAction = operationSaved{
                totalLabel.text = operationAction.operatorType.execute(Double(firstNumber), secondNumber) ?? "0"
                if let operation = operationSaved {
                    operation.isTouching.toggle()
                }
                firstNumberSaved = nil
                operationSaved = nil
            } else {
                totalLabel.text = "0"
            }
        default:
            totalLabel.text = (totalLabel.text == "0") ? sender.currentTitle : (totalLabel.text ?? "") + "\(sender.currentTitle ?? "")"
        }
    }
    
    // MARK: - Action subview special calculator
    
    @objc private func actionSpecialOperation(sender: CalculatorButtonSpecial) {
        switch sender.operatorType {
        case .xSquared, .xСubed, .expInX, .tenInX, .oneDividedByX, .squareRoot, .cubicRoot, .ln, .logTen, .xFactorial, .sinx, .cosx, .tanx, .expan, .sinhx, .coshx, .tanhx, .pi, .rand:
            if let number = Double(totalLabel.text ?? "0") {
                if let result = sender.operatorType.execute(number) {
                    totalLabel.text = result.clean
                }
            }
        default: break
        }
    }
    
}



