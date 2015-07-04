//
//  NODFiancialController.swift
//  NuoDunProject
//
//  Created by redhat' iMac on 15/6/28.
//  Copyright (c) 2015年 lxzhh. All rights reserved.
//

import UIKit

class NODFiancialController: NODBaseMainViewController {
    @IBOutlet weak var supposeToPayLabel: UILabel!
    @IBOutlet weak var alreadyPayedLabel: UILabel!
    @IBOutlet weak var unpaidLabel: UILabel!
    var infoList : Array<NODFinacialInfo!>?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        NODSessionManager.sharedInstance.finacialInfoList { (supposeToPay, alreadyPayed, unpaid, success, list) -> () in
            self.supposeToPayLabel.text = String(supposeToPay!).toCurrency()
            self.alreadyPayedLabel.text = String(alreadyPayed!).toCurrency()
            self.unpaidLabel.text = String(unpaid!).toCurrency()
            self.infoList = list
            self.tableView.reloadData()
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       let pf =  segue.destinationViewController as! NODPersonalFinacialController
        let cell = sender as? UITableViewCell
        pf.info = self.infoList?[(self.tableView.indexPathForCell(cell!))!.row]
    }

    
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.infoList?.count ?? 0)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("NODFinancialCell") as! NODFinancialCell
        cell.setDataWithInfo(self.infoList?[indexPath.row])
        return cell
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120;
    }
}
