//
//  homeController.swift
//  BlessYou
//
//  Created by Mor Soferian on 6/17/20.
//  Copyright © 2020 Mor Soferian. All rights reserved.
//

import UIKit
import GoogleSignIn
import UserNotifications
import GoogleSignIn


class homeController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func didTapSignOut(_ sender: AnyObject) {
        GIDSignIn.sharedInstance().signOut()
        goToSignIn()
   }
    
    @IBAction func onSubscribe(_ sender: Any) {
        goSubscription()
    }
    
    @IBAction func onTodayBirthday(_ sender: Any) {
        goToTodayBirthdays()
    }
    
    public func goSubscription(){
        self.performSegue(withIdentifier: "SubscribeTransition", sender: self)
    }
    
    public func goToSignIn(){
        self.performSegue(withIdentifier: "signInTransition", sender: self)
    }
    
    public func goToTodayBirthdays(){
           self.performSegue(withIdentifier: "TodayBirthdayTransition", sender: self)
    }
    
    @IBAction func onMySubscriptions(_ sender: UIButton) {
         self.performSegue(withIdentifier: "subscriptionsTransition", sender: self)
    }
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "SubscribeTransition"){
            
        }
    }
    
    
}


