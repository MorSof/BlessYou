//
//  SubscriptionsCell.swift
//  BlessYou
//
//  Created by Mor Soferian on 7/4/20.
//  Copyright © 2020 Mor Soferian. All rights reserved.
//

import Foundation
import UIKit

class SubscriptionsCell: UITableViewCell, DeleteProtocol {
    
   
    func onSubscriptionDeleteSuccess() {
        
    }
    
    func onFailure(error: Error?) {
        
    }
    

    @IBOutlet weak var LBL_Name: UILabel!
    @IBOutlet weak var LBL_Date: UILabel!
    @IBOutlet weak var LBL_Type: UILabel!
    
    var birthdayDetails: BirthdayDetails = BirthdayDetails.init(personName: "", dateOfBirth: "", monthDayDateStr: "", type: "", documentId: "")
    
    var birthdayIndex: IndexPath = IndexPath.init()
    var controller: subscriptionsController = subscriptionsController.init()
    
    @IBAction func onDelete(_ sender: UIButton?) {
        print("simba index = \(birthdayIndex.row)")
        controller.cells.remove(at: birthdayIndex.row)
        controller.subscriptions.remove(at: birthdayIndex.row)
        controller.TABLE_tabel.deleteRows(at: [birthdayIndex], with: .fade)
        controller.refreshCellIndexes()
        FireStore.deleteSubscriptions(deleteProtocol: self, documentId: birthdayDetails.documentId)
        
    
    }
    
    @IBAction func onEdit(_ sender: UIButton) {
        controller.selectedBirthday = birthdayDetails
        controller.onEdit()
    }
    
    
}
