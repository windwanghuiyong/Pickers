//
//  SingleComponentPickerViewController.swift
//  Pickers
//
//  Created by wanghuiyong on 21/01/2017.
//  Copyright © 2017 MyOrganization. All rights reserved.
//

import UIKit

// SingleComponentPickerViewController 类同时作为数据源和委托
class SingleComponentPickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet var singlePicker: UIPickerView!
    // 数据源, 硬编码到视图控制器中
    private let characterNames = ["Luke", "Leia", "Han", "Chewbacca", "Artoo", "Threepio", "Lando"]
    
    @IBAction func buttonPressed(_ sender: AnyObject) {
        let row = singlePicker.selectedRow(inComponent: 0)	// 第0个滚轮的第几行
        let name = characterNames[row]
        let title = "Character Name Selected"
        let message = "You selected \(name)"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    // MARK: -
    // MARK: Picker Data Source Protocol Methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView === singlePicker {
            print("选取器的滚轮数为1")
            return 1	// 选取器的滚轮数
        }
        return -1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView === singlePicker && component == 0 {
            print("选取器的行数为\(characterNames.count)")
            return characterNames.count		// 选取器的滚轮的行数
        }
        return -1
    }
    
    // MARK: Picker Delegate Protocol Methods
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        print("选取器的第\(row + 1)行被选中")
        return characterNames[row]
    }
}
