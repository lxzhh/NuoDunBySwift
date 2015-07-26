//
//  NODScheduleDetailController.swift
//  NuoDunProject
//
//  Created by 乐星宇 on 15/7/25.
//  Copyright (c) 2015年 lxzhh. All rights reserved.
//

import UIKit

class NODScheduleDetailController: UITableViewController {
    var schedule : NODSchedule?
    var detail : NODScheduleDetail?
    var containerViewController : NODScheduleContainerController?
    func getDetail(){
        let user = LoginUser.loadSaved()!
        NODSessionManager.sharedInstance.GET("BrowseActivity",
            parameters:["LoginID":user.loginId!,
                        "ZXMBM":self.schedule!.subprojID!],
            success: { (session: NSURLSessionDataTask!,responseObject: AnyObject!) -> Void in
                SVProgressHUD.dismiss()
                let data = responseObject as! NSData
                let xml = SWXMLHash.parse(data)
                let resultString :String? = xml["string"].element?.text
                let jdata: NSData = resultString!.dataUsingEncoding(NSUTF8StringEncoding)!
                let error : NSErrorPointer;
                let json  = JSON(data: jdata)
                let dictionary = json["ZXM"]
                self.detail = Mapper<NODScheduleDetail>().map(json["ZXM"].object)
                println("scheduleList resultString :\(resultString) \n detail:\(self.detail)")
                
                self.tableView.reloadData()
                 self.containerViewController?.setDataWithDetail(self.schedule, detail: self.detail)
            },
            failure :{ (session: NSURLSessionDataTask!,error: NSError!) -> Void in
                println(error)
        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.showWithStatus("加载中")
        self.getDetail()
       
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
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 0
    }

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

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "embed"{
            let d = segue.destinationViewController as! NODScheduleContainerController
           
            println("destination :\(d)")
            containerViewController = d
            
        }
    }
    

}
