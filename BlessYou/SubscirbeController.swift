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
    
    var pickerData: [String] = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.maximumDate = Calendar.current.date(byAdding: .day, value: 0, to: Date())
        self.picker.delegate = self
        self.picker.dataSource = self
        pickerData = ["My Dear Mom", "Far Family", "Brother From Another Mother", "My Army Body", "Far Freind", "My Wife Mom"]

        // Do any additional setup after loading the view.
    }
    

    @IBAction func onDateChanged(_ sender: UIDatePicker) {
//        let dateFormatter = DateFormatter()
//
//        dateFormatter.dateStyle = DateFormatter.Style.short
//        dateFormatter.timeStyle = DateFormatter.Style.short
//
//        let strDate = dateFormatter.string(from: datePicker.date)
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

}
