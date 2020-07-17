//
//  ViewController.swift
//  BlessYou
//
//  Created by Mor Soferian on 6/17/20.
//  Copyright © 2020 Mor Soferian. All rights reserved.
//

import UIKit
import GoogleSignIn
import GoogleSignIn

class signInController: UIViewController, GIDSignInDelegate, SignInProtocol {
    
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
        self.removeSpinner()
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
        self.showSpinner()
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
            TodayBirthdays.todayBirthdays = birthdaysArr
            goToTodayBirthdays()
        }
    }
    
    func onFailure(error: Error?) {
        self.showToast(message: "Somthing went wrong", font: .systemFont(ofSize: 12.0))
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
        self.removeSpinner()
    }
}

extension UIViewController {

func showToast(message : String, font: UIFont) {
    let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 125, y: self.view.frame.size.height-100, width: 250, height: 35))
    toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    toastLabel.textColor = UIColor.white
    toastLabel.font = font
    toastLabel.textAlignment = .center;
    toastLabel.text = message
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 10;
    toastLabel.clipsToBounds  =  true
    self.view.addSubview(toastLabel)
    UIView.animate(withDuration: 10.0, delay: 0.1, options: .curveEaseOut, animations: {
         toastLabel.alpha = 0.0
    }, completion: {(isCompleted) in
        toastLabel.removeFromSuperview()
    })
}
    
}
