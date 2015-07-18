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
        
        if let array = NODGroup.loadSavedJson(NODGroup.self){
            groups = array
            self.selectedGroup = groups?[0] as? NODGroup
        }else{
            NODSessionManager.sharedInstance.QueryGroup { (success, groups) -> () in
                self.groups = groups
                self.selectedGroup = self.groups?[0] as? NODGroup
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
                
            }, origin: genderField)
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
        let mapper = Mapper().toJSONString(worker, prettyPrint: false)
        let dictionary  = ["XGR" : mapper!]
        let json = JSON(dictionary).rawString(encoding: NSUTF8StringEncoding, options: NSJSONWritingOptions(rawValue: 0))
        
        
        let soap = SOAPEngine()
        soap.version = VERSION_WCF_1_1;
        soap.setValue(user.loginId, forKey: "LoginID")
        soap.setValue("", forKey: "GRSC")
        soap.requestURL("http://115.231.54.166:9090/jobrecordapp.asmx",soapAction:"", completeWithDictionary: { (i , list) -> Void in
            
        }) { (error) -> Void in
            
        }
        
    }

}
