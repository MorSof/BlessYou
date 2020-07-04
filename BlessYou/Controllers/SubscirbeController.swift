//
//  ViewController.swift
//  BlessYou
//
//  Created by Mor Soferian on 6/20/20.
//  Copyright © 2020 Mor Soferian. All rights reserved.
//

import UIKit
import SwiftUI

class SubscirbeController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var TXT_personName: UITextField!
    
    var pickerData: [String] = [String]()
    var selectedType: String = ""
    
    var notification: Notification?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.maximumDate = Calendar.current.date(byAdding: .day, value: 0, to: Date())
        self.picker.delegate = self
        self.picker.dataSource = self
        pickerData = ["My Dear Mom", "Far Family", "Brother From Another Mother", "My Army Body", "Far Friend", "My Wife Mom"]
        TXT_personName.text = "Person"
        selectedType = pickerData[0]

    }
    
    
    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return 1
    }
       
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component:Int) -> Int {
           return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        selectedType = pickerData[row]
     }
    
    @IBAction func onSubscribe(_ sender: UIButton) {
        print(TXT_personName.text ?? "Person")
        print(selectedType)
       
        let dateDict: Dictionary<String,Int>! = DateTimeUtil.datePickerToIntDict(datePicker: datePicker)
        let dateStr: String! = DateTimeUtil.datePickerToStringFormat(datePicker: datePicker)
        
        notification = Notification()
        notification?.setContent(title: "Wish \(String(TXT_personName.text!)) Happy Birthday!", subtitle: "Check out the generated wish")
        notification?.trigger(month: dateDict["year"]!, day: dateDict["day"]!)
        
        FireStore.saveSubscription(personName: String(TXT_personName.text!), dateOfBirth: dateStr, type: selectedType)
        self.showToast(message: "Subscription has been set!", font: .systemFont(ofSize: 12.0))
    }
    
}

extension UIViewController {

func showToast(message : String, font: UIFont) {
    let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 125, y: self.view.frame.size.height-100, width: 250, height: 35))
    toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    toastLabel.textColor = UIColor.white
    toastLabel.font = font
    toastLabel.textAlignment = .center;
    toastLabel.text = message
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 10;
    toastLabel.clipsToBounds  =  true
    self.view.addSubview(toastLabel)
    UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
         toastLabel.alpha = 0.0
    }, completion: {(isCompleted) in
        toastLabel.removeFromSuperview()
    })
} }
