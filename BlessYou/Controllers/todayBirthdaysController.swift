//
//  todayBirthdaysController.swift
//  BlessYou
//
//  Created by Mor Soferian on 7/3/20.
//  Copyright © 2020 Mor Soferian. All rights reserved.
//

import UIKit

class todayBirthdaysController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    var birthdaysArr: Array<BirthdayDetails> = []
    
    let cellReuseIdentifier = "birthday_cell"
    
    @IBOutlet weak var TABLE_tabel: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.birthdaysArr[0].printBirthday()
        TABLE_tabel.delegate = self
        TABLE_tabel.dataSource = self
        // Do any additional setup after loading the view.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.birthdaysArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : Cell? = self.TABLE_tabel.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as? Cell
//         cell?.LBL_score?.text = String(self.allScores[indexPath.row].time)
         cell?.LBL_Name?.text = String(self.birthdaysArr[indexPath.row].personName)
//         cell?.LBL_date.text = TimeDateUtil.myDateFormat(date: self.allScores[indexPath.row].date)
         if(cell == nil){
             cell = Cell(style: UITableViewCell.CellStyle.default, reuseIdentifier: cellReuseIdentifier)
         }
         return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        birthdaysArr[indexPath.row].printBirthday()
      }
    
    
}
