//
//  NODScheduleContainerController.swift
//  NuoDunProject
//
//  Created by 乐星宇 on 15/7/25.
//  Copyright (c) 2015年 lxzhh. All rights reserved.
//

import UIKit

class NODScheduleContainerController: UITableViewController {

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var subprojNameLabel: UILabel!
    
    @IBOutlet weak var startDateMLabel: UILabel!
    @IBOutlet weak var startDateYLabel: UILabel!
    @IBOutlet weak var startDateDlabel: UILabel!
    @IBOutlet weak var endDateMLabel: UILabel!
    @IBOutlet weak var endDateYLabel: UILabel!
    @IBOutlet weak var endDateDlabel: UILabel!
    @IBOutlet weak var actualStartDateMLabel: UILabel!
    @IBOutlet weak var actualStartDateYLabel: UILabel!
    @IBOutlet weak var actualStartDateDlabel: UILabel!
    @IBOutlet weak var actualEndDateMLabel: UILabel!
    @IBOutlet weak var actualEndDateYLabel: UILabel!
    @IBOutlet weak var actualEndDateDlabel: UILabel!
    
    @IBOutlet weak var loadLabel: UILabel!
    @IBOutlet weak var contractPriceLabel: UILabel!
    @IBOutlet weak var contractSumPriceLabel: UILabel!
    @IBOutlet weak var workDurationLabel: UILabel!
    @IBOutlet weak var loadPerDayLabel: UILabel!
    @IBOutlet weak var completedLoadLabel: UILabel!
    @IBOutlet weak var completedPercentageLabel: UILabel!


    var schedule : NODSchedule?
    var detail :NODScheduleDetail?
    
    func setDataWithDetail(schedule : NODSchedule?, detail :NODScheduleDetail?){
        self.schedule = schedule
        self.detail = detail
        if let s = schedule{
            subprojNameLabel.text = s.subprojName
            locationLabel.text = s.projLocation
            let startDate = s.startDate?.dateComponent()
            startDateYLabel.text = startDate!.0
            startDateMLabel.text = startDate!.1
            startDateDlabel.text = startDate!.2
            let endDate = s.endDate?.dateComponent()
            endDateYLabel.text = endDate!.0
            endDateMLabel.text = endDate!.1
            endDateDlabel.text = endDate!.2
        }
        if let d = detail{
            loadLabel.text = String(d.projLoad!)
            contractPriceLabel.text = String(d.contractPrice!)
            contractSumPriceLabel.text = String(d.contractSumPrice!)
            workDurationLabel.text = d.workDuration
            loadPerDayLabel.text = d.loadPerDay
            completedLoadLabel.text = String(d.completedLoad!)
            completedPercentageLabel.text = String(d.completedLoad!)
            
            let startDate = d.actualStartDate?.dateComponent()
            actualStartDateYLabel.text = startDate!.0
            actualStartDateMLabel.text = startDate!.1
            actualStartDateDlabel.text = startDate!.2
            let endDate = d.actualEndDate?.dateComponent()
            actualEndDateYLabel.text = endDate!.0
            actualEndDateMLabel.text = endDate!.1
            actualEndDateDlabel.text = endDate!.2
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        return 1
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
