//
//  NODUserViewController.swift
//  NuoDunProject
//
//  Created by lxzhh on 15/6/21.
//  Copyright (c) 2015年 lxzhh. All rights reserved.
//

import UIKit

class NODUserViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var actionMenu: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        actionMenu.scrollEnabled = false
        actionMenu.separatorColor = UIColor.clearColor()
        actionMenu.registerNib(UINib(nibName: "NODMainMenuCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "NODMainMenuCell")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func figurePicker(sender: AnyObject) {
    }

    @IBAction func exitAction(sender: AnyObject) {
    }
   
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.backgroundColor = UIColor.clearColor()
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell =
            tableView.dequeueReusableCellWithIdentifier("NODMainMenuCell") as! NODMainMenuCell
        cell.menuName.text = "施工记录"
        cell.menuIconView.image = UIImage(named: "navbar-进度")
        cell.selectionStyle = UITableViewCellSelectionStyle.Gray
        let darkView = UIView(frame: cell.contentView.bounds)
       
        darkView.backgroundColor = UIColor(red: 0.122, green: 0.173, blue: 0.243, alpha: 1.000)
        cell.selectedBackgroundView = darkView
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
//        self.slideMenuController()?.mainViewController =
    }
}
