//
//  ViewController.swift
//  Calculator
//
//  Created by Gerasim Israyelyan on 5/27/19.
//  Copyright © 2019 Gerasim Israyelyan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var textLabel1: UILabel!
    @IBOutlet var textLabel: UILabel!
    @IBOutlet var buttons: [UIButton]!
    
    var firstValue: Double = 0
    var secondValue: String = ""
    var isFloatingNumber = false
    var result: Double = 0
    var oprtr = "+"
    
    let calculator = Calculator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func butonTapped(_ sender: UIButton) {
    
        switch sender.tag {
        case 0...9, 15: //0...9, .
            calculate(button: sender)
        case 10, 11, 12, 13, 16: // operators
            setOperator(button: sender)
        case 14: //=
            updateValues()
            textLabel1.text = String(format: "%g", result)
            firstValue = result            
            textLabel.text = ""
            self.oprtr = "="
        case 17: //+\-
            if let second = Double(secondValue) {
                secondValue = String(-second)
                guard oprtr != "=" else { return }
                updateValues()
            }
        case 18: //AC
            reset()
        default:
            break
        }
        
    }
    
    private func calculate(button: UIButton) {
        guard !(button.tag == 0 && secondValue == "0" ) else {return} //if secondValue is 0 will not repeat 0
        
        if secondValue == "0" { //textLabel1 without leading 0
            let str = textLabel1.text
            textLabel1.text?.remove(at: str!.index(before: str!.endIndex))
        }
        
        if oprtr == "=" { //reset if operator is "=" && tapped number
            guard button.tag != 15 else {return}
            reset()
        }
        
        if button.tag == 15, !secondValue.contains("."), !secondValue.isEmpty { //add point to secondValue && textLabel1
            secondValue.append(".")
            textLabel1.text?.append(".")
        } else if button.tag != 15 { //add digit to secondValue && textLavel1
            secondValue.append(button.titleLabel!.text!)
            textLabel1.text?.append(button.titleLabel!.text!)
        }
        updateValues()
    }
    
    private func updateValues() {
        let text = textLabel1.text!
        let array = text.split(separator: " ").map{ String($0) }
        var res = calcArray(array: array)
        if !res.isEmpty {
            result = Double(res[0])!
        }
        textLabel.text = String(format: "%g", result)
        
    }
    
    private func calcArray(array: [String]) -> [String] {
        if array.count == 1 {
            return array
        }
        
        for i in 0..<array.count / 2 {
            var buttonPlus: UIButton!
            var buttonMinus: UIButton!
            var buttonMul: UIButton!
            var buttonDiv: UIButton!
            var buttonPercent: UIButton!
            
            buttons.forEach { (button) in
                switch button.tag {
                case 10:
                    buttonPlus = button
                case 11:
                    buttonMinus = button
                case 12:
                    buttonMul = button
                case 13:
                    buttonDiv = button
                case 16:
                    buttonPercent = button
                default:
                    break
                }
            }
            
            let index = 2 * i + 1
    
            if array.contains((buttonMul.titleLabel?.text!)!) {
                if array[index] == buttonMul.titleLabel?.text! {
                    return modifiedArray(operator: (buttonMul.titleLabel?.text!)!, array: array, index: index)
                }
            } else if array.contains((buttonDiv.titleLabel?.text!)!) {
                if array[index] == buttonDiv.titleLabel?.text! {
                    return modifiedArray(operator: (buttonDiv.titleLabel?.text!)!, array: array, index: index)
                }
            } else if array.contains((buttonPercent.titleLabel?.text!)!) {
                if array[index] == buttonPercent.titleLabel?.text! {
                    return modifiedArray(operator: (buttonPercent.titleLabel?.text!)!, array: array, index: index)
                }
            } else if array.contains((buttonPlus.titleLabel?.text!)!) {
                if array[index] == buttonPlus.titleLabel?.text! {
                    return modifiedArray(operator: (buttonPlus.titleLabel?.text!)!, array: array, index: index)
                }
            } else if array.contains((buttonMinus.titleLabel?.text!)!) {
                if array[index] == buttonMinus.titleLabel?.text! {
                    return modifiedArray(operator: (buttonMinus.titleLabel?.text!)!, array: array, index: index)
                }
            }
            
        }
        
        return array
        
    }
    
    private func modifiedArray(operator oprtr: String, array: [String], index: Int) -> [String] {
        var array = array
        let res = calculator.calculate(Operator(rawValue: oprtr)!, of: array[index - 1], and: array[index + 1])
        array[index] = String(res)
        array.remove(at: index + 1)
        array.remove(at: index - 1)
        return calcArray(array: array)
    }
    
    
    private func setOperator(button: UIButton) {
        firstValue = result
        secondValue = ""
        if textLabel1.text!.last != nil{
            if textLabel1.text!.last! == " " {
                textLabel1.text!.removeLast(3)
            }
            textLabel1.text!.append(" " + button.titleLabel!.text! + " ")
            oprtr = button.titleLabel!.text!
        }
    }
    
    private func reset() {
        firstValue = 0
        secondValue = ""
        result = 0
        oprtr = "+"
        textLabel.text = ""
        textLabel1.text = ""
    }
    
    
}

