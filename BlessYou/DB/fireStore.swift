//
//  fireStore.swift
//  BlessYou
//
//  Created by Mor Soferian on 6/23/20.
//  Copyright © 2020 Mor Soferian. All rights reserved.
//

import Foundation
import Firebase
import FirebaseCore
import FirebaseFirestore

class FireStore{
    
    static func saveSubscription(personName: String, dateOfBirth: String, dateOfBirthMonthDay: String, type: String){
        let fireStore = Firestore.firestore()
        fireStore.collection("users").document(UserGoogle.email).collection("subscriptions").document(UUID().uuidString).setData(
        [
            "personName" : personName,
            "dateOfBirth": dateOfBirth,
            "type": type,
            "dateOfBirthMonthDay" : dateOfBirthMonthDay
        ])
    }
    
    
    static func fetchTodayBirthdays(signInController : SignInProtocol) {
        var todayBirthdays: Array<BirthdayDetails> = []
        let fireStore = Firestore.firestore()
        let todayDateStrMonthDay = DateTimeUtil.dateToStringMonthDay(date: Date.init())
        
        fireStore.collection("users").document(UserGoogle.email).collection("subscriptions").whereField("dateOfBirthMonthDay", isEqualTo: todayDateStrMonthDay).getDocuments{ (snapshot,error) in
            if error == nil && snapshot?.documents != nil {
                for document in snapshot!.documents{
                    let documentData = document.data()
                    let birthday = BirthdayDetails.init(personName: documentData["personName"] as! String, dateOfBirth: documentData["dateOfBirth"]! as! String, monthDayDateStr: documentData["dateOfBirthMonthDay"] as! String, type: documentData["type"]! as! String)
                    todayBirthdays.append(birthday)
                }
            }
            signInController.onFetchedBirthdaysSuccess(birthdaysArr: todayBirthdays)
        }
    }
    
    static func fetchWishesByType(type: String, blessController : BlessProtocol){
        var wishes: Array<String> = []
        let fireStore = Firestore.firestore()
        fireStore.collection("Wishes").document(type).getDocument { (document, error) in
            if let document = document, document.exists {
                for (_, value) in document.data()! {
                    wishes.append(value as! String)
                }
                blessController.onFetchedWishesSuccess(wishes: wishes)
            } else {
                blessController.onFailure(error: error)
            }
            
        }
    }
    
    static func fetchUserSubscriptions(subscriptionsController : SubscriptionsProtocol){
        var subscriptions: Array<BirthdayDetails> = []
        let fireStore = Firestore.firestore()
        fireStore.collection("users").document(UserGoogle.email).collection("subscriptions").getDocuments{ (snapshot,error) in
            if error == nil && snapshot?.documents != nil {
                for document in snapshot!.documents{
                    print(document.documentID)
                    let documentData = document.data()
                    let birthday = BirthdayDetails.init(personName: documentData["personName"] as! String, dateOfBirth: documentData["dateOfBirth"]! as! String, monthDayDateStr: documentData["dateOfBirthMonthDay"] as! String, type: documentData["type"]! as! String)
                    subscriptions.append(birthday)
                }
            }
            subscriptionsController.onFetchedSubscriptionsSuccess(subscriptions: subscriptions)
        }
    }
    
    
}
