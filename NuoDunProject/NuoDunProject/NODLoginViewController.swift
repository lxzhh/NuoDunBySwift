//
//  NODLoginViewController.swift
//  NuoDunProject
//
//  Created by lxzhh on 15/6/21.
//  Copyright (c) 2015年 lxzhh. All rights reserved.
//

import UIKit

class NODLoginViewController: UIViewController {

    @IBOutlet weak var pwdTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //"YYQ0-ZJND201502","MM":"13484265"
    @IBAction func loginAction(sender: AnyObject) {
        SVProgressHUD.showWithStatus("登录中")
        NODSessionManager.sharedInstance.login(nameTextField.text, password: pwdTextField.text) { (loginSuccess : Bool) -> () in
            if (loginSuccess){
                SVProgressHUD.dismiss()
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
