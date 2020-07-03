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

class homeController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    @IBAction func didTapSignOut(_ sender: AnyObject) {
        print("here")
        GIDSignIn.sharedInstance().signOut()
        goToSignIn()
   }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
      // Perform any operations when the user disconnects from app here.
        print("signing out")
        goToSignIn()
    }
    
    @IBAction func onSubscribe(_ sender: Any) {
        goSubscription()
    }
    
    public func goSubscription(){
        self.performSegue(withIdentifier: "SubscribeTransition", sender: self)
    }
    
    public func goToSignIn(){
        self.performSegue(withIdentifier: "signInTransition", sender: self)
    }
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "SubscribeTransition"){
            
        }
    }
    
    
}


