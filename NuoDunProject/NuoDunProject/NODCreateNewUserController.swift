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
        NODSessionManager.sharedInstance.createNewWorker(newWorker, completion: { (success) -> () in
            
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
