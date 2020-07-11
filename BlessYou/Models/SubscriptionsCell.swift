//
//  SubscriptionsCell.swift
//  BlessYou
//
//  Created by Mor Soferian on 7/4/20.
//  Copyright © 2020 Mor Soferian. All rights reserved.
//

import Foundation
import UIKit

class SubscriptionsCell: UITableViewCell {
    

    @IBOutlet weak var LBL_Name: UILabel!
    @IBOutlet weak var LBL_Date: UILabel!
    @IBOutlet weak var LBL_Type: UILabel!
    
    var birthdayDetails: BirthdayDetails = BirthdayDetails.init(personName: "", dateOfBirth: "", monthDayDateStr: "", type: "", documentId: "", notificationId: "")
    
    var birthdayIndex: IndexPath = IndexPath.init()
    var controller: subscriptionsController = subscriptionsController.init()
    
    @IBAction func onDelete(_ sender: UIButton?) {
        controller.onDelete(birthdayIndex: birthdayIndex, birthdayDetails: birthdayDetails)
    
    }
    
    @IBAction func onEdit(_ sender: UIButton) {
        controller.selectedBirthday = birthdayDetails
        controller.onEdit()
    }
    
    
}
