//
//  CustomPickerViewController.swift
//  Pickers
//
//  Created by wanghuiyong on 21/01/2017.
//  Copyright © 2017 MyOrganization. All rights reserved.
//

import UIKit
import AudioToolbox

class CustomPickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    private var images: [UIImage]!	// 图片数组
    @IBOutlet var picker: UIPickerView!
    @IBOutlet var winLabel: UILabel!
    @IBOutlet var button: UIButton!
    private var winSoundID: SystemSoundID = 0
    private var crunchSoundID: SystemSoundID = 0
    let componentNum = 5

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        images = [
            UIImage.init(named: "seven")!, 
            UIImage.init(named: "bar")!,
            UIImage.init(named: "crown")!,
            UIImage.init(named: "cherry")!,
            UIImage.init(named: "lemon")!,
            UIImage.init(named: "apple")!,
        ]
        winLabel.text = " "
    }
    
    @IBAction func buttonPressed(_ sender: AnyObject) {
        var win = false
        var numInRow = -1	// 行中当前相同图像数
        var lastVal = -1		// 上一个滚轮的值
        
        for i in 0..<componentNum {
            let newValue = Int(arc4random_uniform(UInt32(images.count)))
            if newValue == lastVal {
                numInRow += 1
            } else {
                numInRow = 1
            }
            lastVal = newValue
            
            picker.selectRow(newValue, inComponent: i, animated: true)
            picker.reloadComponent(i)
            if numInRow >= 3 {
                win = true
            }
        }
        
        if crunchSoundID == 0 {
            let soundURL = Bundle.main.url(forResource: "crunch", withExtension: "wav")
            AudioServicesCreateSystemSoundID(soundURL as! CFURL, &crunchSoundID)
        }
        AudioServicesPlaySystemSound(crunchSoundID)
        
        if win {
            perform(NSSelectorFromString("playWinSound"), with: nil, afterDelay: 0.5)
        } else {
            perform(NSSelectorFromString("showButton"), with: nil, afterDelay: 0.5)
        }
        self.button.isHidden = true
        winLabel.text = " "
//    	winLabel.text = win ? "WINNER!" : "TRYING"
    }
    
    // MARK: -
    // MARK: Picker Data Source Meghods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return componentNum
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return images.count
    }
    
    // MARK: -
    // MARK: Picker Delegate Methods
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let image = images[row]
        let imageView = UIImageView(image: image)
        print("component\(component) row\(row)")
        return imageView
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        print("64")
        return 64
    }
    
    func showButton() {
        button.isHidden = false
    }
    
    func playWinSound() {
        // 加载声音
        if winSoundID == 0 {
            let soundURL = Bundle.main.url(forResource: "win", withExtension: "wav")
            AudioServicesCreateSystemSoundID(soundURL as! CFURL, &winSoundID)
        }
        AudioServicesPlaySystemSound(winSoundID)
        winLabel.text = "WINNER!"
        perform(NSSelectorFromString("showButton"), with: nil, afterDelay: 1.5)
    }
}
