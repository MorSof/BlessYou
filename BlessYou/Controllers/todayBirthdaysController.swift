//
//  todayBirthdaysController.swift
//  BlessYou
//
//  Created by Mor Soferian on 7/3/20.
//  Copyright © 2020 Mor Soferian. All rights reserved.
//

import UIKit
import GoogleSignIn

class todayBirthdaysController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var selectedBirthday: BirthdayDetails?
    let cellReuseIdentifier = "birthday_cell"
    
    @IBOutlet weak var TABLE_tabel: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SoundManager.playSound(.happyBirthdayCheers)
        TABLE_tabel.delegate = self
        TABLE_tabel.dataSource = self
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TodayBirthdays.todayBirthdays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : TodayBirthdaysCell? = self.TABLE_tabel.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as? TodayBirthdaysCell
         cell?.LBL_Name?.text = String(TodayBirthdays.todayBirthdays[indexPath.row].personName)
        let image : UIImage = UIImage(named:"baloons1")!
        cell?.IMG_left_img.image = image
        cell?.IMG_right_img.image = image
        cell?.LBL_type.text = String(TodayBirthdays.todayBirthdays[indexPath.row].type)
         if(cell == nil){
             cell = TodayBirthdaysCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: cellReuseIdentifier)
         }
         return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedBirthday = TodayBirthdays.todayBirthdays[indexPath.row]
        goToBless()
      }
    
    public func goToBless(){
            self.performSegue(withIdentifier: "BlessTransition", sender: self)
       }
       
    @IBAction func goHome(_ sender: UIButton) {
        self.performSegue(withIdentifier: "HomeTransition", sender: self)
    }
    
    //MARK: Navigation
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if(segue.identifier == "BlessTransition"){
               let vc = segue.destination as! blessController
               vc.birthdayDetails = self.selectedBirthday
           }
       }
}
