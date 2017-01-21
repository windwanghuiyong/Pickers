//
//  DatePickerViewController.swift
//  Pickers
//
//  Created by wanghuiyong on 21/01/2017.
//  Copyright © 2017 MyOrganization. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController {
    @IBOutlet var datePicker: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()

        // 初始化日期选取器的日期为当前时间
//        let date = NSDate()
        let date = Date()
        datePicker.setDate(date, animated: true)
    }
    
    @IBAction func buttonPressed(_ sender: AnyObject) {
        let date = datePicker.date	// 日期选取器不需要数据源, 可直接读取日期
        // 日期格式
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "ch_CH")
    	dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        print("the current time is ", dateFormatter.string(from: date))
        
    	let title = "Date and Time Selected"
        let message = "The date and time you selected is \(date)"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)	// 警告视图
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
