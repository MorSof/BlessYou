//
//  dateTimeUtil.swift
//  BlessYou
//
//  Created by Mor Soferian on 7/3/20.
//  Copyright © 2020 Mor Soferian. All rights reserved.
//

import Foundation
import UIKit

class DateTimeUtil {
    
    public static func datePickerToStringFormatFull(datePicker: UIDatePicker!) -> String {
        let components = datePicker.calendar.dateComponents([.year, .month, .day],
               from: datePicker.date)
        let year = components.year!
        let month = components.month!
        let day = components.day!
        return String(format: "%d-%02d-%02d",year, month, day)
    }
    
    public static func datePickerToStringFormatMonthDay(datePicker: UIDatePicker!) -> String {
           let components = datePicker.calendar.dateComponents([.month, .day],
                  from: datePicker.date)
           let month = components.month!
           let day = components.day!
           return String(format: "%02d-%02d", month, day)
       }
    
    public static func datePickerToIntDict(datePicker: UIDatePicker!) -> Dictionary<String,Int> {
        let components = datePicker.calendar.dateComponents([.year, .month, .day],
               from: datePicker.date)
        let year: Int = components.year!
        let month: Int = components.month!
        let day: Int = components.day!
        let dict:[String:Int] = ["year":year, "month":month, "day":day]
        return dict
    }
    
    public static func dateToStringFull(date: Date)->String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
    
    public static func dateToStringMonthDay(date: Date)->String{
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd"
        return formatter.string(from: date)
    }
    
}
