//
//  ViewController.swift
//  BlessYou
//
//  Created by Mor Soferian on 6/17/20.
//  Copyright © 2020 Mor Soferian. All rights reserved.
//

import UIKit
import GoogleSignIn

class signInController: UIViewController, GIDSignInDelegate {

    @IBOutlet weak var BTN_sign_in: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().delegate = self
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
      // Perform any operations on signed in user here.
        UserGoogle.userId = user.userID                  // For client-side use only!
        UserGoogle.idToken = user.authentication.idToken // Safe to send to the server
        UserGoogle.fullName = user.profile.name
        UserGoogle.givenName = user.profile.givenName
        UserGoogle.familyName = user.profile.familyName
        UserGoogle.email = user.profile.email
        print(UserGoogle.familyName)
        goHome()

    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
      // Perform any operations when the user disconnects from app here.
      // ...
    }
    
    
    //------------------------------------------------------------------
    
    
     public func goHome(){
        self.performSegue(withIdentifier: "HomeTransition", sender: self)
    }
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "HomeTransition"){
            
        }
    }
    

}

