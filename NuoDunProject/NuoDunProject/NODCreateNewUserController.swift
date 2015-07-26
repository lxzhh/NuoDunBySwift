//
//  NODCreateNewUserController.swift
//  NuoDunProject
//
//  Created by lxzhh on 15/7/11.
//  Copyright (c) 2015年 lxzhh. All rights reserved.
//

import UIKit

class NODCreateNewUserController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var groupSelectionButton: UIButton!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var genderField: UITextField!
    @IBOutlet weak var idCodeField: UITextField!
    @IBOutlet weak var originField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var telePhoneField: UITextField!
    @IBOutlet weak var accountBankField: UITextField!
    @IBOutlet weak var accountNameField: UITextField!
    @IBOutlet weak var accountNumberField: UITextField!
    
    @IBOutlet weak var entryDateField: UITextField!
    
    @IBOutlet weak var basicSalaryField: UITextField!
    
    @IBOutlet weak var dailySalaryField: UITextField!
    
    var selectedGroup : NODGroup?
    var groups : [NODObject]?
    var newWorker : NODWorker = NODWorker()
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.showWithStatus("加载班组")
        if let array = NODGroup.loadSavedJson(NODGroup.self){
            groups = array
            self.selectedGroup = groups?[0] as? NODGroup
            SVProgressHUD.dismiss()
        }else{
            NODSessionManager.sharedInstance.QueryGroup { (success, groups) -> () in
                self.groups = groups
                self.selectedGroup = self.groups?[0] as? NODGroup
                SVProgressHUD.dismiss()
            }
        }
        genderField.inputView = UIView()
        genderField.inputAccessoryView = UIView()
    }

    @IBAction func groupSelect(sender: AnyObject) {
        let rows = NODGroup.loadSavedJson(NODGroup.self)
        let names = (rows! as NSArray).valueForKey("groupName") as! Array<String>
        let picker = ActionSheetStringPicker(title: "班组", rows:names , initialSelection: 0, doneBlock: { (picker, index, o ) -> Void in
                self.groupSelectionButton.setTitle(o as? String, forState: UIControlState.Normal)
            self.selectedGroup = rows?[index]
            }, cancelBlock: { (picker) -> Void in
                
            }, origin: sender)
        picker.showActionSheetPicker()
    }
    
    
    @IBAction func createAction(sender: AnyObject) {
        newWorker.groupId = self.selectedGroup?.groupID
        newWorker.workerName = self.nameField.text
        newWorker.gender = genderField.text
        newWorker.identityNumber = idCodeField.text
        newWorker.originPlace = originField.text
        newWorker.address = addressField.text
        newWorker.telephone = telePhoneField.text
        newWorker.bankName = accountBankField.text
        newWorker.bankAccountName = accountNameField.text
        newWorker.bankAccount = accountNumberField.text
        newWorker.entryDate = entryDateField.text
        newWorker.basicSalary = (basicSalaryField.text as NSString).floatValue
        newWorker.dailySalary = (dailySalaryField.text as NSString).floatValue
        self.createNewWorker(newWorker, completion: { (success) -> () in
            
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
//        println("textFieldShouldBeginEditing :\(textField)")
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if(textField == genderField) {
            let picker = ActionSheetStringPicker(title: "性别", rows: ["男","女"], initialSelection: 0, doneBlock: { (picker, index, o) -> Void in
                textField.text = o as! String
                }, cancelBlock: { (picker) -> Void in
                    
                }, origin: genderField)
            picker.showActionSheetPicker()
        }
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func createNewWorker(worker :NODWorker, completion:(success :Bool)-> ()){
        let user = LoginUser.loadSaved()!
//        let mapper = Mapper().toJSONString(worker, prettyPrint: false)
        var dict = Mapper().toJSON(worker) as Dictionary
        let jbgz = dict["JBGZ"] as!  Float
        let rgz = dict["RGZ"] as! Float
        dict["JBGZ"] = "\(jbgz)"
        dict["RGZ"] = "\(rgz)"

        let dictionary  = ["XGR" : dict]
        let json = JSON(dictionary).rawString(encoding: NSUTF8StringEncoding, options: NSJSONWritingOptions(rawValue: 0))

        var soapMessage = "<v:Envelope xmlns:i='http://www.w3.org/2001/XMLSchema-instance' xmlns:d='http://www.w3.org/2001/XMLSchema' xmlns:c='http://www.w3.org/2003/05/soap-encoding' xmlns:v='http://www.w3.org/2003/05/soap-envelope'><v:Header /><v:Body><NewWorker xmlns='http://tempuri.org/' id='o0' c:root='1'><LoginID i:type='d:string'>\(user.loginId!)</LoginID><GRSC i:type='d:string'>\(json!)</GRSC></NewWorker></v:Body></v:Envelope>"
        
        var urlString = "http://115.231.54.166:9090/jobrecordapp.asmx"
        
        var url = NSURL(string: urlString)
        
        var theRequest = NSMutableURLRequest(URL: url!)
        
        var msgLength = String(count(soapMessage))
        
        theRequest.addValue("application/soap+xml;charset=utf-8", forHTTPHeaderField: "Content-Type")
        theRequest.addValue(msgLength, forHTTPHeaderField: "Content-Length")
        theRequest.HTTPMethod = "POST"
        theRequest.HTTPBody = soapMessage.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) // or false
        
        let requestOperation = AFHTTPRequestOperation(request: theRequest)
        requestOperation.setCompletionBlockWithSuccess({ (operation, responseObject) -> Void in
            let data = responseObject as! NSData
            let xml = SWXMLHash.parse(data)
            let resultString :String? = xml["soap:Envelope"]["soap:Body"]["NewWorkerResponse"]["NewWorkerResult"].element?.text
            if resultString!.rangeOfString("\"status\":true") != nil{
                SVProgressHUD.showSuccessWithStatus("成功创建")
                
                self.navigationController?.popViewControllerAnimated(true)
            }else
            {
                 SVProgressHUD.showErrorWithStatus("创建失败，请检查填写的数据")
            }
            
            }, failure: { (operation, error) -> Void in
                SVProgressHUD.showErrorWithStatus("创建失败，请检查填写的数据")
        })
        requestOperation.start()
    }
    
    
}



