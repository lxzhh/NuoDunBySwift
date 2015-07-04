//
//  NODUserViewController.swift
//  NuoDunProject
//
//  Created by lxzhh on 15/6/21.
//  Copyright (c) 2015年 lxzhh. All rights reserved.
//

import UIKit

class NODUserViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    let menuIcons  :Array<String> = ["img_menu_task","img_menu_labour","img_menu_wage","img_menu_schedule","img_menu_settings"]
    let menuTitles :Array<String> = ["施工记录",    "劳务管理",    "薪酬一览",   "项目进度",    "设置"]
    var currentSelectedIndex = -1
    @IBOutlet weak var actionMenu: UITableView!
    @IBOutlet weak var userNameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        actionMenu.scrollEnabled = false
        actionMenu.separatorColor = UIColor.clearColor()
        actionMenu.registerNib(UINib(nibName: "NODMainMenuCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "NODMainMenuCell")
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let loginUser = LoginUser.loadSaved()
        userNameLabel.text = loginUser?.userName
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
        cell.menuName.text = menuTitles[indexPath.row]
        cell.menuIconView.image = UIImage(named: menuIcons[indexPath.row])
        cell.selectionStyle = UITableViewCellSelectionStyle.Gray
        let darkView = UIView(frame: cell.contentView.bounds)
       
        darkView.backgroundColor = UIColor(red: 0.122, green: 0.173, blue: 0.243, alpha: 1.000)
        cell.selectedBackgroundView = darkView
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.row != currentSelectedIndex){
            currentSelectedIndex = indexPath.row
            var slideType :NODSlideMainViewType
            switch indexPath.row{
            case 0: slideType = .NODSlideMainViewTypeHome
            case 1: slideType = .NODSlideMainViewTypeLabour
            case 2: slideType = .NODSlideMainViewTypeFinacial
            case 4: slideType = .NODSlideMainViewTypeSetting
            default:
                slideType = .NODSlideMainViewTypeSetting
            }
            self.slideMenuController()?.slideMainViewWithType(slideType)

        }else{
            self.slideMenuController()?.closeLeft()
        }
        
    }
}
