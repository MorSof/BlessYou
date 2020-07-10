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
    
    static func saveSubscription(bithdayDetails: BirthdayDetails) -> String{
        let fireStore = Firestore.firestore()
        let documentId = bithdayDetails.documentId == "" ? UUID().uuidString : bithdayDetails.documentId
        fireStore.collection("users").document(UserGoogle.email).collection("subscriptions").document(documentId).setData(
        [
            "personName" : bithdayDetails.personName,
            "dateOfBirth": bithdayDetails.dateOfBirth,
            "type": bithdayDetails.type,
            "dateOfBirthMonthDay" : bithdayDetails.monthDayDateStr
        ])
        return documentId
    }
    
    
    static func fetchTodayBirthdays(signInController : SignInProtocol) {
        var todayBirthdays: Array<BirthdayDetails> = []
        let fireStore = Firestore.firestore()
        let todayDateStrMonthDay = DateTimeUtil.dateToStringMonthDay(date: Date.init())
        
        fireStore.collection("users").document(UserGoogle.email).collection("subscriptions").whereField("dateOfBirthMonthDay", isEqualTo: todayDateStrMonthDay).getDocuments{ (snapshot,error) in
            if error == nil && snapshot?.documents != nil {
                for document in snapshot!.documents{
                    let documentData = document.data()
                    let birthday = BirthdayDetails.init(personName: documentData["personName"] as! String, dateOfBirth: documentData["dateOfBirth"]! as! String, monthDayDateStr: documentData["dateOfBirthMonthDay"] as! String, type: documentData["type"]! as! String, documentId: document.documentID)
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
                    let documentData = document.data()
                    let birthday = BirthdayDetails.init(personName: documentData["personName"] as! String, dateOfBirth: documentData["dateOfBirth"]! as! String, monthDayDateStr: documentData["dateOfBirthMonthDay"] as! String, type: documentData["type"]! as! String, documentId: document.documentID)
                    subscriptions.append(birthday)
                }
            }
            subscriptionsController.onFetchedSubscriptionsSuccess(subscriptions: subscriptions)
        }
    }
    
    static func deleteSubscriptions( deleteProtocol: DeleteProtocol, documentId: String){
        
        let fireStore = Firestore.firestore()
    fireStore.collection("users").document(UserGoogle.email).collection("subscriptions").document(documentId).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document \(documentId) successfully removed!")
                deleteProtocol.onSubscriptionDeleteSuccess()
            }
        }
    }
    
    
}
