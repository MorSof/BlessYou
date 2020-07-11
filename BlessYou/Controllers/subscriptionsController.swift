//
//  subscriptionsController.swift
//  BlessYou
//
//  Created by Mor Soferian on 7/4/20.
//  Copyright © 2020 Mor Soferian. All rights reserved.
//

import UIKit
import GoogleSignIn

class subscriptionsController: UIViewController, UITableViewDelegate, UITableViewDataSource, SubscriptionsProtocol, DeleteProtocol {
    
    
    @IBOutlet weak var TABLE_tabel: UITableView!
    let cellReuseIdentifier = "subscriptions_cell"
    var subscriptions: Array<BirthdayDetails> = []
    var cells: Array<SubscriptionsCell> = []
    var selectedBirthday: BirthdayDetails?
    
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
        cell?.birthdayDetails = subscriptions[indexPath.row]
        cell?.birthdayIndex = IndexPath.init(item: indexPath.item, section: indexPath.section)
        cell?.controller = self
        cells.append(cell!)
        
         if(cell == nil){
             cell = SubscriptionsCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: cellReuseIdentifier)
         }
         return cell!
    }
    
    func refreshCellIndexes(){
        var counter = 0
        for cell in cells {
            cell.birthdayIndex = IndexPath.init(item: counter, section: 0)
            counter += 1
        }
    }
    
    func onFetchedSubscriptionsSuccess(subscriptions: Array<BirthdayDetails>) {
        self.subscriptions = subscriptions
        DispatchQueue.main.async { self.TABLE_tabel.reloadData() }
    }
      
    @IBAction func goHome(_ sender: UIButton) {
        self.performSegue(withIdentifier: "HomeTransition", sender: self)
    }
    
    func onEdit(){
        self.performSegue(withIdentifier: "EditTransition", sender: self)
    }
    
    func onDelete(birthdayIndex: IndexPath, birthdayDetails: BirthdayDetails){
        let refreshAlert = UIAlertController(title: "Refresh", message: "Are You Sure You Want To Delete The Subscription?.", preferredStyle: UIAlertController.Style.alert)

        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            self.cells.remove(at: birthdayIndex.row)
            self.subscriptions.remove(at: birthdayIndex.row)
            self.TABLE_tabel.deleteRows(at: [birthdayIndex], with: .fade)
            self.refreshCellIndexes()
            FireStore.deleteSubscriptions(deleteProtocol: self, documentId: birthdayDetails.documentId)
            Notification.deleteNotification(notificationId: self.subscriptions[birthdayIndex.row].notificationId)
        }))

        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
              print("Handle Cancel Logic here")
        }))

        present(refreshAlert, animated: true, completion: nil)
        
    }
    
    func onSubscriptionDeleteSuccess() {
        self.showToast(message: "Subscription has been Deleted!", font: .systemFont(ofSize: 12.0))
    }
    
    func onFailureDelete(error: Error?) {
        self.showToast(message: "Somthing went wrong!", font: .systemFont(ofSize: 12.0))

    }
    
    func onFailure(error: Error?) {
        self.showToast(message: "Somthing went wrong!", font: .systemFont(ofSize: 12.0))

    }

    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "EditTransition"){
            let vc = segue.destination as! SubscirbeController
            vc.birthdayToEdit = selectedBirthday
            vc.headline = "Edit a Birthday"

        }
    }
}
