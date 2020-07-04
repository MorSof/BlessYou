//
//  blessController.swift
//  BlessYou
//
//  Created by Mor Soferian on 7/4/20.
//  Copyright © 2020 Mor Soferian. All rights reserved.
//

import UIKit
import GoogleSignIn

class blessController: UIViewController, BlessProtocol {
    
    @IBOutlet weak var LBL_title: UILabel!
    @IBOutlet weak var BTN_clipboard: UIButton!
    
    @IBOutlet weak var TXT_wish: UITextView!
    var wishes: Array<String> = []
    var birthdayDetails: BirthdayDetails?
    var wishIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LBL_title.text = "Wish \(birthdayDetails!.personName) Happy Birthday!"
        FireStore.fetchWishesByType(type: birthdayDetails!.type, blessController: self)
    }
    
    func onFetchedWishesSuccess(wishes: Array<String>) {
        self.wishes = wishes
        generateWish()
    }
    
    func onFailure(error: Error?) {
        
    }
    
    func generateWish(){
        wishIndex = Int.random(in: 0 ..< wishes.count)
        
        let aString = wishes[wishIndex]
        let newString = aString.replacingOccurrences(of: birthdayDetails!.type, with: birthdayDetails!.personName)
        
        TXT_wish.text = newString
    }

    @IBAction func onClipboardPressed(_ sender: UIButton) {
        
        let pasteboard = UIPasteboard.general
        pasteboard.string = TXT_wish.text
        
    }
    @IBAction func goHome(_ sender: UIButton) {
        self.performSegue(withIdentifier: "HomeTransition", sender: self)
    }
    
    
    @IBAction func onReturn(_ sender: UIButton) {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}
