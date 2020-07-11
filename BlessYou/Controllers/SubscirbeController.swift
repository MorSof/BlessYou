//
//  ViewController.swift
//  BlessYou
//
//  Created by Mor Soferian on 6/20/20.
//  Copyright © 2020 Mor Soferian. All rights reserved.
//

import UIKit
import SwiftUI
import GoogleSignIn

class SubscirbeController: UIViewController {
    
    @IBOutlet weak var TXT_personName: UITextField!
    @IBOutlet weak var LBL_title: UILabel!
    
    var birthdayToEdit: BirthdayDetails?
    var headline: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TXT_personName.text = "Person"
        LBL_title.text = headline
        birthdayToEdit = birthdayToEdit == nil ? BirthdayDetails.init(personName: "", dateOfBirth: "", monthDayDateStr: "", type: "", documentId: "", notificationId: "") : birthdayToEdit
    }
    
    @IBAction func onNext(_ sender: UIButton) {
        self.performSegue(withIdentifier: "DateTransition", sender: self)
    }
    
    @IBAction func goHome(_ sender: UIButton) {
        self.performSegue(withIdentifier: "HomeTransition", sender: self)
    }
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "DateTransition"){
            let vc = segue.destination as! chooseDateController
            vc.personName = TXT_personName.text!
            vc.birthdayToEdit = birthdayToEdit
            vc.headline = headline
        }
    }
    
}


