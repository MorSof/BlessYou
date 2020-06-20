//
//  homeController.swift
//  BlessYou
//
//  Created by Mor Soferian on 6/17/20.
//  Copyright © 2020 Mor Soferian. All rights reserved.
//

import UIKit
import GoogleSignIn

class homeController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func didTapSignOut(_ sender: AnyObject) {
        GIDSignIn.sharedInstance().signOut()
        goToSignIn()
   }

    @IBAction func onSubscribe(_ sender: Any) {
        goToSignIn()
    }
    
    public func goToSignIn(){
        self.performSegue(withIdentifier: "SubscribeTransition", sender: self)
    }
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "SubscribeTransition"){
            
        }
    }
    
    
}
