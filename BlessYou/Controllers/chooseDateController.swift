//
//  chooseDateController.swift
//  BlessYou
//
//  Created by Mor Soferian on 7/4/20.
//  Copyright © 2020 Mor Soferian. All rights reserved.
//

import UIKit
import GoogleSignIn

class chooseDateController: UIViewController {

    var personName = ""
    var dateDict: Dictionary<String,Int>! = [:]
    var fullDateStr: String! = ""
    var monthDayDateStr: String! = ""
    var birthdayToEdit: BirthdayDetails?
    var headline: String?
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var LBL_title: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LBL_title.text = headline
    datePicker.maximumDate = Calendar.current.date(byAdding: .day, value: 0, to: Date())
    }
    

    @IBAction func onNextPressed(_ sender: UIButton) {
        
        dateDict = DateTimeUtil.datePickerToIntDict(datePicker: datePicker)
        fullDateStr = DateTimeUtil.datePickerToStringFormatFull(datePicker: datePicker)
        monthDayDateStr = DateTimeUtil.datePickerToStringFormatMonthDay(datePicker: datePicker)
        goToType()
        
    }
    
    func goToType(){
         self.performSegue(withIdentifier: "TypeTransition", sender: self)
    }
    
       
    @IBAction func goHome(_ sender: UIButton) {
         self.performSegue(withIdentifier: "HomeTransition", sender: self)
    }
    
    @IBAction func onReturn(_ sender: UIButton) {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    //MARK: Navigation
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if(segue.identifier == "TypeTransition"){
               let vc = segue.destination as! chooseTypeController
            vc.personName = personName
            vc.dateDict = dateDict
            vc.fullDateStr = fullDateStr
            vc.monthDayDateStr = monthDayDateStr
            vc.birthdayToEdit = birthdayToEdit
            vc.headline = headline
           }
       }

}
