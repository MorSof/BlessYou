//
//  chooseTypeController.swift
//  BlessYou
//
//  Created by Mor Soferian on 7/4/20.
//  Copyright © 2020 Mor Soferian. All rights reserved.
//

import UIKit
import GoogleSignIn

class chooseTypeController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var personName = ""
    var dateDict: Dictionary<String,Int>! = [:]
    var fullDateStr: String! = ""
    var monthDayDateStr: String! = ""
    var birthdayToEdit: BirthdayDetails?

    var notification: Notification?
    var headline: String?

    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var BTN_submit: UIButton!
    @IBOutlet weak var LBL_title: UILabel!
    
    var pickerData: [String] = [String]()
    var selectedType: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        LBL_title.text = headline
        let buttonName = birthdayToEdit?.documentId == "" ? "Submit" : "Finish Editing"
        BTN_submit.setTitle(buttonName, for: .normal)
        self.picker.delegate = self
        self.picker.dataSource = self
        pickerData = ["Best Friend", "My Dear Mom", "Far Family", "My Army Body", "Far Friend", "Brother"]
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

    @IBAction func onSubscribe(_ sender: Any) {
        
        let notificationId = setNotification()
        let bithdayDetails = BirthdayDetails.init(personName: String(personName), dateOfBirth: fullDateStr, monthDayDateStr: monthDayDateStr, type: selectedType, documentId: self.birthdayToEdit!.documentId, notificationId: notificationId)
        bithdayDetails.documentId = FireStore.saveSubscription(bithdayDetails: bithdayDetails)
        todayBirthdayLogic(bithdayDetails: bithdayDetails)
        self.showToast(message: "Subscription has been set!", font: .systemFont(ofSize: 12.0))
        goToSubscriptions()
    }
    
    func setNotification() -> String{
        notification = Notification()
        notification?.setContent(title: "Wish \(String(personName)) Happy Birthday!", subtitle: "Check out the generated wish")
        let notificationId = notification?.trigger(month: dateDict["month"]!, day: dateDict["day"]!)
        return notificationId!
    }
    
    func todayBirthdayLogic(bithdayDetails: BirthdayDetails){
        let todayDate = DateTimeUtil.dateToStringMonthDay(date: Date.init())
        if monthDayDateStr == todayDate || birthdayToEdit?.monthDayDateStr == todayDate{
            
            if(monthDayDateStr == birthdayToEdit?.monthDayDateStr){
                removeByDocIdAndInsert(bithdayDetails: bithdayDetails)
            }else if birthdayToEdit?.documentId == "" || (birthdayToEdit?.monthDayDateStr != todayDate && monthDayDateStr == todayDate){
                TodayBirthdays.todayBirthdays.append(bithdayDetails)
            }else if(birthdayToEdit?.monthDayDateStr == todayDate && birthdayToEdit?.documentId != ""){
                removeByDoc(bithdayDetails: bithdayDetails)
            }
        
        }
    }
    
    func removeByDocIdAndInsert(bithdayDetails: BirthdayDetails){
        var counter = 0
        for birthday in TodayBirthdays.todayBirthdays{
            if birthdayToEdit?.documentId == birthday.documentId{
                TodayBirthdays.todayBirthdays.remove(at: counter)
                TodayBirthdays.todayBirthdays.insert(bithdayDetails, at: counter)
                return
            }
            counter += 1
        }
    }
    
    func removeByDoc(bithdayDetails: BirthdayDetails){
        var counter = 0
        for birthday in TodayBirthdays.todayBirthdays{
            if birthdayToEdit?.documentId == birthday.documentId{
                TodayBirthdays.todayBirthdays.remove(at: counter)
                return
            }
            counter += 1
        }
    }
    
    @IBAction func onHomePressed(_ sender: UIButton) {
         self.performSegue(withIdentifier: "HomeTransition", sender: self)
    }
    
    func goToSubscriptions(){
        self.performSegue(withIdentifier: "subscriptionsTransition", sender: self)
    }
    
    @IBAction func onReturn(_ sender: UIButton) {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
}
