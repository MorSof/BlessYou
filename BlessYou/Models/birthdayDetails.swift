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
    var type: String
    
    init(personName: String, dateOfBirth: String, type: String) {
        self.personName = personName
        self.dateOfBirth = dateOfBirth
        self.type = type
    }
    
    func printBirthday(){
        
        print(" personName = \(personName)\n dateOfBirth = \(dateOfBirth)\n type = \(type)")
        
    }
    
    
}
