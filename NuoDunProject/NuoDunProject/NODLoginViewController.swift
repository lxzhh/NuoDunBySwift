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
        NODSessionManager.sharedInstance.GET("APPLogin", parameters:["LoginID":nameTextField.text,"MM":pwdTextField.text], success: { (session: NSURLSessionDataTask!,responseObject: AnyObject!) -> Void in
           
            let data = responseObject as! NSData
            let xml = SWXMLHash.parse(data)
            let resultString :String? = xml["string"].element?.text
            let user  = Mapper<LoginUser>().map(resultString!)
            println("resultString:\(resultString) user \(user)")
            if (user!.loginCode! == "1"){
                self.dismissViewControllerAnimated(true, completion: nil)
            }
            
            }) { (session: NSURLSessionDataTask!,error: NSError!) -> Void in
                println(error)
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
