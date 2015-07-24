//
//  NODLabourController.swift
//  NuoDunProject
//
//  Created by redhat' iMac on 15/7/4.
//  Copyright (c) 2015年 lxzhh. All rights reserved.
//

import UIKit
protocol NODLabourDelegate{
    func labourDidSelectedWithResult([NODLabour]?) -> ()
}


class NODLabourController: NODBaseMainViewController {
    var labourCateList : Array<NODLabourCategory>?
    var selectedSection : Int = NSNotFound
    var labourdDelegate: NODLabourDelegate?
    var labourDidSeclectedAction :(([NODLabour]?) -> ())?
    var needEditing : Bool? = false
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tableView.editing = true
        self.tableView.allowsMultipleSelectionDuringEditing = true
        self.tableView.registerNib(UINib(nibName: "NODLabourSectionCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "NODLabourSectionCell")
        NODSessionManager.sharedInstance.labourInfoList { (success, list) -> () in
            self.labourCateList = list;
            self.tableView.reloadData()
        }
        self.tableView.tableFooterView = UIView()
        
        if self.needEditing! == true{
            self.tableView.editing = true
            self.navigationItem.leftBarButtonItem = nil
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "navbar-确定"), style: UIBarButtonItemStyle.Plain, target: self, action: Selector("finishSelect"))
            
        }
    }

    func finishSelect(){
        let selectedIndexPathList = self.tableView.indexPathsForSelectedRows()
        let result : [NODLabour]? =  selectedIndexPathList?.map{ (ip : AnyObject) -> NODLabour in
            let indexPath = ip as! NSIndexPath
            let category = self.labourCateList?[indexPath.section]
            let info = category?.labourList?[indexPath.row]
            return info!
        }
        println("result :\(result)")
        self.labourDidSeclectedAction?(result)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK: - Table view data source

    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterViewWithIdentifier("NODLabourSectionCell") as! NODLabourSectionCell
        headerView.backgroundView = UIView(frame: headerView.bounds)
        headerView.backgroundView?.backgroundColor = UIColor(red: 0.647, green: 0.906, blue: 1.000, alpha: 1.000)
        let category = self.labourCateList?[section]
        headerView.labourCategoryLabel.text = category?.categoryName
        headerView.gestureRecognizers?.foreach{headerView.removeGestureRecognizer($0 as! UIGestureRecognizer)}
        let tap = UITapGestureRecognizer()
        tap.rac_gestureSignal().subscribeNext({ (x) -> Void in
            println("section\(section)")
            let sections = NSMutableIndexSet(index: section)
            if(section == self.selectedSection){
                self.selectedSection = NSNotFound
            }else{
                if(self.selectedSection != NSNotFound){sections.addIndex(self.selectedSection)}
                self.selectedSection = section
            }
            self.tableView.reloadSections(sections, withRowAnimation: UITableViewRowAnimation.Automatic)
            
            //                self.tableView.scrollRectToVisible(CGRectMake(0, 0, 0, 0), animated: true)
        })
        headerView.addGestureRecognizer(tap)
        
        return headerView
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return self.labourCateList?.count ?? 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == self.selectedSection || tableView.editing) {
            let category = self.labourCateList![section]
            return category.labourList?.count ?? 0
        }else{
            return 0
        }
    }

   
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell
        let category = self.labourCateList?[indexPath.section]
        let info = category?.labourList?[indexPath.row]
        // Configure the cell...
        cell.imageView?.image = UIImage (named: "labour_worker_icon")
        cell.textLabel?.text = info?.labourName
        cell.detailTextLabel?.text = info?.labourId
        return cell
    }
    
    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return .None
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

    override func  shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        return !self.tableView.editing
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "CreateNew"){
            
        }else{
            let workerDetail =  segue.destinationViewController as! NODWorkerDetailsController
            let cell = sender as? UITableViewCell
            let indexPath = self.tableView.indexPathForCell(cell!)!
            let category = self.labourCateList?[indexPath.section]
            let info = category?.labourList?[indexPath.row]
            workerDetail.workId = info?.labourId
        }
    }


}
