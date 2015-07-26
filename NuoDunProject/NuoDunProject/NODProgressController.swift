//
//  NODProgressController.swift
//  NuoDunProject
//
//  Created by 乐星宇 on 15/7/25.
//  Copyright (c) 2015年 lxzhh. All rights reserved.
//

import UIKit

class NODProgressController: NODBaseMainViewController {
    @IBOutlet weak var projNameLabel: UILabel!

    var scheduleList  : [NODSchedule]?
    func requestToGetProgress(){
        
        let user = LoginUser.loadSaved()!
        NODSessionManager.sharedInstance.GET("BrowseSchedule",
            parameters:["LoginID":user.loginId!],
            success: { (session: NSURLSessionDataTask!,responseObject: AnyObject!) -> Void in
                SVProgressHUD.dismiss()
                let data = responseObject as! NSData
                let xml = SWXMLHash.parse(data)
                let resultString :String? = xml["string"].element?.text
                let jdata: NSData = resultString!.dataUsingEncoding(NSUTF8StringEncoding)!
                let error : NSErrorPointer;
                let json  = JSON(data: jdata)
                let list  = Mapper<NODSchedule>().mapArray(json["JD"].arrayObject)
                println("scheduleList resultString :\(resultString) \n detail:\(list)")
                self.scheduleList = list
                self.tableView.reloadData()
            },
            failure :{ (session: NSURLSessionDataTask!,error: NSError!) -> Void in
                println(error)
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            SVProgressHUD.showWithStatus("加载中")
        });
        
        self.requestToGetProgress()
        projNameLabel.text = LoginUser.loadSaved()?.projName
        // Do any additional setup after loading the view.
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return  1
    }
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.backgroundColor = UIColor.clearColor()
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.scheduleList?.count ?? 0
        
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> NODScheduleCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("NODScheduleCell") as! NODScheduleCell
        cell.setDateWithSchedule(self.scheduleList?[indexPath.row])
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "detail"{
            let cell = sender as! UITableViewCell
            let indexPath = self.tableView.indexPathForCell(cell)!
            let subproj = self.scheduleList?[indexPath.row]
            let detailVC = segue.destinationViewController as! NODScheduleDetailController
            detailVC.schedule = subproj
           
        }
    }

}
