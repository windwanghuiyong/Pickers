//
//  DependentComponentPickerViewController.swift
//  Pickers
//
//  Created by wanghuiyong on 21/01/2017.
//  Copyright © 2017 MyOrganization. All rights reserved.
//

import UIKit

class DependentComponentPickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet var dependentPicker: UIPickerView!		// 选取器
    private let stateComponent = 0					// 选取器组件(滚轮)索引号
    private let zipComponent = 1
    private var stateZips: [String : [String]]!		// 键是字符串, 值是字符串数组
    private var states: [String]!					// 所有键
    private var zips: [String]!						// 某个键的所有值

    override func viewDidLoad() {
        super.viewDidLoad()

//        let bundle = NSBundle.mainBundle()
        let bundle = Bundle.main			// 获取应用程序包对象 
        let plistURL = bundle.url(forResource: "statedictionary", withExtension: "plist")	// 属性列表资源路径
        stateZips = NSDictionary(contentsOf: plistURL!) as! [String: [String]]				// 加载资源到字典对象
        
        // 提取键
        let allstates = stateZips.keys
//        states = sorted(allstates)
    	states = allstates.sorted()
        // 提取第0个键的值
        let selectedState = states[0]
        zips = stateZips[selectedState]
    }
    
    @IBAction func buttonPressed(_ sender: AnyObject) {
        let stateRow = dependentPicker.selectedRow(inComponent: stateComponent)
        let zipRow = dependentPicker.selectedRow(inComponent: zipComponent)
        let state = states[stateRow]
        let zip = zips[zipRow]
        let title = "State and a Zip of the State are Selected"
        let message = "\(zip) is in \(state)"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
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
        if component == stateComponent {
            print("共有\(states.count)个州")
            return states.count
        } else {
            print("共有\(zips.count)个邮编")
            return zips.count
        }
    }
    
    // MARK: -
    // MARK: Picker Delegate Protocol Methods
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == stateComponent {
            print("左侧滚轮\(component)的第\(row + 1)行被选中")
            return states[row]
        } else {
            print("右侧滚轮\(component)的第\(row + 1)行被选中")
            return zips[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // 左侧滚轮发生变化
        if component == stateComponent {
            let selectedState = states[row]
            zips = stateZips[selectedState]					// 按键检索值, 更新右侧滚轮数据
            dependentPicker.reloadComponent(zipComponent)	// 重新加载右侧滚轮
            dependentPicker.selectRow(stateComponent, inComponent: zipComponent, animated: true)	// 丢掉返回的行数
            print("右侧滚轮变化, 重新加载")
        }
    }
    
    // 调整滚轮宽度
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        let pickerWidth = pickerView.bounds.size.width
        if component == zipComponent {
            print("右侧滚轮占1/3")
            return pickerWidth * 1 / 3
        } else {
            print("左侧滚轮占2/3")
            return pickerWidth * 2 / 3
        }
    }
}
