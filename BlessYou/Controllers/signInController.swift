//
//  ViewController.swift
//  BlessYou
//
//  Created by Mor Soferian on 6/17/20.
//  Copyright © 2020 Mor Soferian. All rights reserved.
//

import UIKit
import GoogleSignIn

class signInController: UIViewController, GIDSignInDelegate, SignInProtocol {

    var birthdaysArr: Array<BirthdayDetails> = []
    
    @IBOutlet weak var BTN_sign_in: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        googleSignConf()
    }
    
    @IBAction func onSignIn(_ sender: GIDSignInButton) {
        googleSignConf()
    }
    
    @IBAction func didTapSignOut(_ sender: AnyObject) {
      GIDSignIn.sharedInstance().signOut()
    }
    
    private func googleSignConf(){
        GIDSignIn.sharedInstance()?.presentingViewController = self
        // Automatically sign in the user.
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
    }
    
    //---------------------Google sign in-----------------------------
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
      if let error = error {
        if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
          print("The user has not signed in before or they have since signed out.")
        } else {
          print("\(error.localizedDescription)")
        }
        return
      }

        UserGoogle.userId = user.userID                  // For client-side use only!
        UserGoogle.idToken = user.authentication.idToken // Safe to send to the server
        UserGoogle.fullName = user.profile.name
        UserGoogle.givenName = user.profile.givenName
        UserGoogle.familyName = user.profile.familyName
        UserGoogle.email = user.profile.email
        print(UserGoogle.familyName)
        FireStore.fetchTodayBirthdays(signInController: self)
        
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
      // Perform any operations when the user disconnects from app here.
        print("signing out")
        goToSignIn()
    }
    
    
    //------------------------------------------------------------------
    
    
    
    func onFetchedBirthdaysSuccess(birthdaysArr: Array<BirthdayDetails>) {
        if birthdaysArr.isEmpty{
            print("Empty Birthdays")
            goHome()
        }
        else{
            print(" Not Empty Birthdays (Good!)")
            self.birthdaysArr = birthdaysArr
            goToTodayBirthdays()
        }
    }
    
    func onFailure(error: Error?) {
        
    }
    
     public func goHome(){
        self.performSegue(withIdentifier: "HomeTransition", sender: self)
    }
    
    public func goToSignIn(){
        self.performSegue(withIdentifier: "signInTransition", sender: self)
    }
    
    public func goToTodayBirthdays(){
         self.performSegue(withIdentifier: "TodayBirthdayTransition", sender: self)
    }
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "TodayBirthdayTransition"){
            let vc = segue.destination as! todayBirthdaysController
            vc.birthdaysArr = self.birthdaysArr
        }
    }
    
}

