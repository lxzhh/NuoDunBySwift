//
//  NODWorkerDetailsController.swift
//  NuoDunProject
//
//  Created by redhat' iMac on 15/7/4.
//  Copyright (c) 2015年 lxzhh. All rights reserved.
//

import UIKit

class NODWorkerDetailsController: UITableViewController {
    var workId : String?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var idNumberLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var contactInfoLabel: UILabel!
    @IBOutlet weak var bankInfoLabel: UILabel!
    @IBOutlet weak var EntryDateLabel: UILabel!
    @IBOutlet weak var basicSalaryLabel: UILabel!
    @IBOutlet weak var dailySalaryLabel: UILabel!
    @IBOutlet weak var bankAccountLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "工人资料"
        NODSessionManager.sharedInstance.getWorkerDetail(workId, completion: { (success, worker : NODWorker?) -> () in
            if(success!){
                self.nameLabel.text = worker?.workerName
                self.groupLabel.text = worker?.workCate
                self.genderLabel.text = worker?.gender
                self.idNumberLabel.text = worker?.identityNumber
                self.originLabel.text = worker?.originPlace
                self.addressLabel.text = worker?.address
                self.contactInfoLabel.text = worker?.telephone
                self.bankInfoLabel.text = worker?.bankName
                self.bankAccountLabel.text = worker?.bankAccount
                self.EntryDateLabel.text = worker?.entryDate
                self.basicSalaryLabel.text = String(format: "￥%.2f", worker!.basicSalary!)
                self.dailySalaryLabel.text = String(format: "￥%.2f", worker!.dailySalary!)
            }
        })
 
    }

    @IBAction func uploadPhoto(sender: AnyObject) {
        let actionSheet =  UIActionSheet(title: "拍照上传", delegate: nil, cancelButtonTitle: "取消", destructiveButtonTitle: nil)
        actionSheet.addButtonWithTitle("个人照片")
        actionSheet.addButtonWithTitle("身份证正面")
        actionSheet.addButtonWithTitle("身份证反面")

        actionSheet.rac_buttonClickedSignal().subscribeNext { (x) -> Void in
            let row = x as! Int
            let imagePicker =  UIImagePickerController()
            imagePicker.rac_imageSelectedSignal().subscribeNext({ (x) -> Void in
                
            })
            imagePicker.sourceType = .Camera
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
        actionSheet.showInView(self.view.superview)
    }
    
    @IBAction func quitJob(sender: AnyObject) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    // MARK: - Table view data source

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        return cell
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
