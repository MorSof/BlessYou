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
    
    static func saveSubscription(personName: String, dateOfBirth: String, type: String){
        let fireStore = Firestore.firestore()
        fireStore.collection("users").document(UserGoogle.email).collection("subscriptions").document(UUID().uuidString).setData(
            [
             "personName" : personName,
             "dateOfBirth": dateOfBirth,
             "type": type
        ])
    }
    
    
    static func fetchTodayBirthdays(signInController : SignInProtocol) {
        var todayBirthdays: Array<Any> = []
        let fireStore = Firestore.firestore()
        
        let todayDateStr = DateTimeUtil.dateToString(date: Date.init())
        print(todayDateStr)
        
        fireStore.collection("users").document(UserGoogle.email).collection("subscriptions").whereField("dateOfBirth", isEqualTo: todayDateStr).getDocuments{ (snapshot,error) in
            if error == nil && snapshot?.documents != nil {
                for document in snapshot!.documents{
                    let documentData = document.data()
                    print(documentData["personName"]!)
                    print(documentData["dateOfBirth"]!)
                    todayBirthdays.append(documentData)
                }
            }
            signInController.onFetchedBirthdaysSuccess(birthdaysArr: todayBirthdays)
        }
    }
    
}
