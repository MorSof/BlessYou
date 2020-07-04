//
//  subscriptionsController.swift
//  BlessYou
//
//  Created by Mor Soferian on 7/4/20.
//  Copyright © 2020 Mor Soferian. All rights reserved.
//

import UIKit
import GoogleSignIn

class subscriptionsController: UIViewController, UITableViewDelegate, UITableViewDataSource, SubscriptionsProtocol {
  
    @IBOutlet weak var TABLE_tabel: UITableView!
    let cellReuseIdentifier = "subscriptions_cell"
    var subscriptions: Array<BirthdayDetails> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TABLE_tabel.delegate = self
        TABLE_tabel.dataSource = self
        FireStore.fetchUserSubscriptions(subscriptionsController: self)
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subscriptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : SubscriptionsCell? = self.TABLE_tabel.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as? SubscriptionsCell
         cell?.LBL_Name?.text = String(subscriptions[indexPath.row].personName)
        
        cell?.LBL_Type?.text = String(subscriptions[indexPath.row].type)
        cell?.LBL_Date?.text = String(subscriptions[indexPath.row].dateOfBirth)

         if(cell == nil){
             cell = SubscriptionsCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: cellReuseIdentifier)
         }
         return cell!
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        selectedBirthday = subscriptions[indexPath.row]
//        goToBless()
//      }
    
    
    func onFetchedSubscriptionsSuccess(subscriptions: Array<BirthdayDetails>) {
        self.subscriptions = subscriptions
        DispatchQueue.main.async { self.TABLE_tabel.reloadData() }
    }
      
    func onFailure(error: Error?) {
          
    }
      

    @IBAction func goHome(_ sender: UIButton) {
        self.performSegue(withIdentifier: "HomeTransition", sender: self)
    }
    

}
