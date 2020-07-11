//
//  birthdayDetails.swift
//  BlessYou
//
//  Created by Mor Soferian on 7/3/20.
//  Copyright © 2020 Mor Soferian. All rights reserved.
//

import Foundation

class BirthdayDetails {
    
    var personName: String
    var dateOfBirth: String
    var monthDayDateStr: String
    var type: String
    var documentId: String
    var notificationId: String
    
    init(personName: String, dateOfBirth: String, monthDayDateStr: String, type: String, documentId: String, notificationId: String) {
        self.personName = personName
        self.dateOfBirth = dateOfBirth
        self.type = type
        self.monthDayDateStr = monthDayDateStr
        self.documentId = documentId
        self.notificationId = notificationId
    }
    
    func printBirthday(){
        
        print(" personName = \(personName)\n dateOfBirth = \(dateOfBirth)\n type = \(type)\n monthDayDateStr = \(monthDayDateStr) \n documentId = \(documentId)")
        
    }
     
    
}
