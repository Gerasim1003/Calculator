//
//  Calculator.swift
//  Calculator
//
//  Created by Gerasim Israyelyan on 5/27/19.
//  Copyright © 2019 Gerasim Israyelyan. All rights reserved.
//

import Foundation

enum Operator: String {
    case plus = "+"
    case minus = "−"
    case multiply = "×"
    case divide = "÷"
    case percent = "%"
}

class Calculator {
    
    func calculate(_ oprtr: Operator, of firstValue: Any, and secondValue: Any) -> Double {
        guard let firstValue = self.castAsDouble(firstValue)  else {
            print("Wrong first value")
            return 0
        }
        guard let secondValue = self.castAsDouble(secondValue)  else {
            print("Wrong second value")
            return 0
        }
        
        return calculate(oprtr, of: firstValue, and: secondValue)
    }
    
    private func calculate(_ oprtr: Operator, of firstValue: Double, and secondValue: Double) -> Double {
        switch oprtr {
        case .plus:
            return firstValue + secondValue
        case .minus:
            return firstValue - secondValue
        case .multiply:
            return firstValue * secondValue
        case .divide:
            return firstValue / secondValue
        case .percent:
            return firstValue * secondValue / 100
            
        }
    }
    
    private func castAsDouble(_ value: Any) -> Double? {
        if let value = value as? Double {
            return value
        } else if let value = value as? Int {
            return Double(value)
        } else if let value = value as? String {
            return Double(value)
        } else {
            return nil
        }
    }
    
}

