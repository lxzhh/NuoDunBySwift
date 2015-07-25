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

    var scheduleList  : [AnyObject]?
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
                let groups  = json.arrayObject as! [NODSchedule]?
                println("QueryGroup resultString :\(resultString) \n detail:\(groups)")
                self.scheduleList = groups
                self.tableView.reloadData()
            },
            failure :{ (session: NSURLSessionDataTask!,error: NSError!) -> Void in
                println(error)
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.showWithStatus("加载中")
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
    

    

}
