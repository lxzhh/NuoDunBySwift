//
//  NODConstructionController.swift
//  NuoDunProject
//
//  Created by lxzhh on 15/7/5.
//  Copyright (c) 2015年 lxzhh. All rights reserved.
//

import UIKit

class NODConstructionController: NODBaseMainViewController {
    var currentPage : Int? = 1
    @IBOutlet weak var projNameLabel: UILabel!
    var contructionList : Array<NODConstructionInfo>?
    
    
    func requestForWeeak(week : Int){
        NODSessionManager.sharedInstance.getContructionList(week, completion: { (success, list) -> () in
            self.contructionList = list
            self.tableView.reloadData()
        })
    }
    
    func loadData(){
        if((LoginUser.loadSaved()) != nil){
            projNameLabel.text = LoginUser.loadSaved()?.projName
            self.requestForWeeak(1)
            NODSessionManager.sharedInstance.queryEverything()
        }
    }
    
    @IBAction func addRecord(sender: AnyObject) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerNib(UINib(nibName: "NODLabourSectionCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "NODLabourSectionCell")
    
        self.refreshControl?.rac_signalForControlEvents(UIControlEvents.ValueChanged).subscribeNext({  [weak self] (x) -> Void in
            if let strongSelf = self{
                strongSelf.refreshControl?.endRefreshing()
            }
            })
        self.tableView.addInfiniteScrollingWithActionHandler { [weak self]() -> Void in
            if let strongSelf = self{
                strongSelf.tableView.infiniteScrollingView.stopAnimating()
                strongSelf.requestForWeeak(strongSelf.currentPage!++)
            }
        }
        self.tableView.tableFooterView = UIView()
        self.loadData()
        NSNotificationCenter.defaultCenter().rac_addObserverForName("loginNotification", object: nil).subscribeNext { (o : AnyObject!) -> Void in
            self.loadData()
            
        }
    
    }
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, 60))
        
        headerView.backgroundColor = UIColor(red: 23/255.0, green: 176/255.0, blue: 255/255.0, alpha: 1)
        return headerView;
    }
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return   LoginUser.loadSaved()?.projName
    }
    override func tableView(tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 0
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
       
        return self.contructionList?.count ?? 0
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("NODContructionCell", forIndexPath: indexPath) as! NODContructionCell
        cell.setDataWithConstructionInfo(self.contructionList?[indexPath.row])
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "createRcord"){
            
        }else{
            let constructionDetail =  segue.destinationViewController as! NODConstructionDetailController
            let cell = sender as? UITableViewCell
            let indexPath = self.tableView.indexPathForCell(cell!)!
            let construction = self.contructionList?[indexPath.row]
            println("\(construction)")
            constructionDetail.subProjId = construction?.subProjId
            constructionDetail.constructionDate = construction?.constructionDate
        }
        
    }
}
