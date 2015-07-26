//
//  NODSettingViewController.swift
//  NuoDunProject
//
//  Created by redhat' iMac on 15/6/28.
//  Copyright (c) 2015年 lxzhh. All rights reserved.
//

import UIKit

class NODSettingViewController: NODBaseMainViewController {


    override func viewDidLoad() {
        super.viewDidLoad()


    }



    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if indexPath.section == 2{
            let alertView = UIAlertView(title: "版权所有", message: "宁波筑业软件研发有限公司\n© 2015 Zhejiang Norton Construction Co. Ltd. All Rights Reserved", delegate: nil, cancelButtonTitle: "确定")

            alertView.rac_buttonClickedSignal().subscribeNext { (x) -> Void in
                let number = x as! Int
                
            }
            alertView.show()
        }
        
    }

}
