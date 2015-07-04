//
//  NODPersonalFinacialController.swift
//  NuoDunProject
//
//  Created by redhat' iMac on 15/7/4.
//  Copyright (c) 2015年 lxzhh. All rights reserved.
//

import UIKit

class NODPersonalFinacialController: UITableViewController {
    @IBOutlet weak var supposeToPayLabel: UILabel!
    @IBOutlet weak var alreadyPayedLabel: UILabel!
    @IBOutlet weak var unpaidLabel: UILabel!
    @IBOutlet weak var dateButton: UIButton!
    var personalList : Array<NODFinacialInfo>?
    var info : NODFinacialInfo?
    override func viewDidLoad() {
        super.viewDidLoad()

//        if(info != nil){
//            self.title = info?.userName
//            supposeToPayLabel.text = String(info!.supposeToPay!).toCurrency()
//            alreadyPayedLabel.text = String(info!.alreadyPayed!).toCurrency()
//            unpaidLabel.text = String(info!.unpaid!).toCurrency()
//        }
        SVProgressHUD.showWithStatus("加载中");
        NODSessionManager.sharedInstance.personalFinacialInfoList(info?.userID, completion: {(date, supposeToPay, alreadyPayed, unpaid, success, list) -> () in
            SVProgressHUD.dismiss();
            self.title = self.info?.userName
            self.dateButton.setTitle(date, forState: UIControlState.Normal)
            self.supposeToPayLabel.text = supposeToPay!
            self.alreadyPayedLabel.text =  alreadyPayed!
            self.unpaidLabel.text = unpaid!
            self.personalList = list
            self.tableView.reloadData()
        })
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.personalList?.count ?? 0
    }
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.backgroundColor = UIColor.clearColor()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("NODPersionalFiancialCell" , forIndexPath :indexPath) as! NODPersionalFiancialCell
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.setDataWithInfo(self.personalList?[indexPath.row])
        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }


}
