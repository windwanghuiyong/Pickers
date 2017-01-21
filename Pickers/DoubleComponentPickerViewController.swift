//
//  DoubleComponentPickerViewController.swift
//  Pickers
//
//  Created by wanghuiyong on 21/01/2017.
//  Copyright © 2017 MyOrganization. All rights reserved.
//

import UIKit

class DoubleComponentPickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet var doublePicker: UIPickerView!
    private let fillingComponent = 0		// 滚轮的索引值
    private let breadComponent = 1
    // 数据源, 硬编码到控制器中
    private let fillingTypes = ["Ham", "Turkey", "Peanut Butter", "Tuna Salad", "Chicken Salad", "Roast Beef", "Vegemit"]
    private let breadTypes = ["White", "Whole wheat", "Rye", "Sourdough", "Seven Grain"]

    @IBAction func buttonPressed(_ sender: AnyObject) {
        // 请求选中的行
        let fillingRow = doublePicker.selectedRow(inComponent: fillingComponent)
        let breadRow = doublePicker.selectedRow(inComponent: breadComponent)
        let filling = fillingTypes[fillingRow]
        let bread = breadTypes[breadRow]
        let title = "Your Ordered Your Bread"
        let message = "Your \(filling) on \(bread) bread will be right up."
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Great", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: -
    // MARK: Picker Data Source Protocol Methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        print("共有2个滚轮")
        return 2
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == breadComponent {
            print("共有\(breadTypes.count)种面包")
            return breadTypes.count
        } else {
            print("共有\(fillingTypes.count)种馅料")
            return fillingTypes.count
        }
    }
    // MARK: -
    // MARK: Picker Delegate Protocol Methods
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == breadComponent {
            print("第\(row + 1)行面包")
            return breadTypes[row]
        } else {
            print("第\(row + 1)行馅料")
            return fillingTypes[row]
        }
    }
}
