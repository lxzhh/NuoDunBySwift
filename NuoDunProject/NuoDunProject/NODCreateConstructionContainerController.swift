//
//  NODCreateConstructionContainerController.swift
//  NuoDunProject
//
//  Created by lxzhh on 15/7/19.
//  Copyright (c) 2015年 lxzhh. All rights reserved.
//

import UIKit

extension Dictionary {
    mutating func merge<K, V>(dict: [K: V]){
        for (k, v) in dict {
            self.updateValue(v as! Value, forKey: k as! Key)
        }
    }
}

class NODCreateConstructionContainerController: UITableViewController {
    let selectionTitles  = ["核实并登记器具","核实并登记材料及其数量","核实并登记施工人员"]
    let selectionIcons = ["机具","材料","施工人员"]
    var containerViewController : NODCreateContructionController?
    var machineList : [NODMachine]?
    var materialList : [NODMaterial]?
    var workerList : [NODLabour]?
    override func viewDidLoad() {
        super.viewDidLoad()
        machineList = NODMachine.loadSavedJson(NODMachine.self)
        materialList = NODMaterial.loadSavedJson(NODMaterial.self)
        workerList = NODLabour.loadSavedJson(NODLabour.self)
    }

    func reloadSelectionDatas(){
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0:
            return 1 + (containerViewController?.currentPhase?.machineList?.count ?? 0)
        case 1:
            return 1 + (containerViewController?.currentPhase?.materialList?.count ?? 0)
        case 2:
            return 1 + (containerViewController?.currentPhase?.workerList?.count ?? 0)
        default:
            return 1
        }
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if(indexPath.row == 0){
            let cell = tableView.dequeueReusableCellWithIdentifier("selectionData", forIndexPath: indexPath) as! NODAddObjectCell
            cell.iconView.image = UIImage(named: self.selectionIcons[indexPath.section])
            cell.selectTitleLabel.text = self.selectionTitles[indexPath.section]
            cell.actionButton.rac_signalForControlEvents(UIControlEvents.TouchUpInside).takeUntil(cell.rac_prepareForReuseSignal).subscribeNext { (x) -> Void in
                switch indexPath.section{
                case 0:
                    let names = (self.machineList! as NSArray).valueForKey("machineName") as! Array<String>
                    let picker = ActionSheetStringPicker(title: "器具", rows:names , initialSelection: 0, doneBlock: { (picker, index, o ) -> Void in
                        let selectedMachine = self.machineList?[index]
                        self.containerViewController?.currentPhase?.machineList?.insert(selectedMachine!, atIndex: 0)
                        tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 1, inSection: indexPath.section)], withRowAnimation: UITableViewRowAnimation.Automatic)
                        }, cancelBlock: { (picker) -> Void in
                            
                        }, origin: cell.actionButton)
                    picker.showActionSheetPicker()
                    
                    
                case 1:
                    
                    let names = (self.materialList! as NSArray).valueForKey("materialName") as! Array<String>
                    let picker = ActionSheetStringPicker(title: "材料", rows:names , initialSelection: 0, doneBlock: { (picker, index, o ) -> Void in
                        let selectedOne = self.materialList?[index]
                        self.containerViewController?.currentPhase?.materialList?.insert(selectedOne!, atIndex: 0)
                        tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 1, inSection: indexPath.section)], withRowAnimation: UITableViewRowAnimation.Automatic)
                        }, cancelBlock: { (picker) -> Void in
                            
                        }, origin: cell.actionButton)
                    picker.showActionSheetPicker()
                case 2:
                    let names = (self.workerList! as NSArray).valueForKey("labourName") as! Array<String>
                    let picker = ActionSheetStringPicker(title: "材料", rows:names , initialSelection: 0, doneBlock: { (picker, index, o ) -> Void in
                        let selectedOne = self.workerList?[index]
                        self.containerViewController?.currentPhase?.workerList?.insert(selectedOne!, atIndex: 0)
                        tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 1, inSection: indexPath.section)], withRowAnimation: UITableViewRowAnimation.Automatic)
                        }, cancelBlock: { (picker) -> Void in
                            
                        }, origin: cell.actionButton)
                    picker.showActionSheetPicker()
                default:
                    println()
                }
            }
            return cell
        }else{
            let cell = tableView.dequeueReusableCellWithIdentifier("NODRemoveObjectCell", forIndexPath: indexPath) as! NODRemoveObjectCell
            switch indexPath.section{
            case 0:
                cell.objectNameField.text =  self.containerViewController?.currentPhase?.machineList?[indexPath.row-1].machineName
            case 1:
                cell.objectNameField.text =  self.containerViewController?.currentPhase?.materialList?[indexPath.row-1].materialName
            case 2:
                cell.objectNameField.text =  self.containerViewController?.currentPhase?.workerList?[indexPath.row-1].labourName
            default:
                println()
            }
            if indexPath.section == 1{
                let material = self.containerViewController?.currentPhase?.materialList?[indexPath.row-1]
                cell.countPromptLabel.hidden = false
                cell.countField.hidden = false
                cell.countField.rac_signalForControlEvents(UIControlEvents.EditingDidEnd).takeUntil(cell.rac_prepareForReuseSignal).subscribeNext{ (x) -> Void in
                    let field = x as! UITextField
                    material?.materialCount = field.text.toInt()
                }
            }
            //删除按钮
            cell.deleteButton.rac_signalForControlEvents(UIControlEvents.TouchUpInside).takeUntil(cell.rac_prepareForReuseSignal).subscribeNext{ (x) -> Void in
                switch indexPath.section{
                case 0:
                    self.containerViewController?.currentPhase?.machineList?.removeAtIndex(indexPath.row-1)
                case 1:
                    self.containerViewController?.currentPhase?.materialList?.removeAtIndex(indexPath.row-1)
                case 2:
                    self.containerViewController?.currentPhase?.workerList?.removeAtIndex(indexPath.row-1)
                default:
                    println()
                }
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            }
            return cell
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let d = segue.destinationViewController as! NODCreateContructionController
        println("destination :\(d)")
        containerViewController = d
        d.parentVC = self
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
    @IBAction func createNewContructionAction(sender: AnyObject) {
        let newContruction = NODConstructionDetail()
        newContruction.constructionLocation = self.containerViewController?.contructionLocationLabel.text
        newContruction.constructionDate = self.containerViewController?.dateButton.titleLabel?.text
        newContruction.subProjName = self.containerViewController?.subprojNameLabbel.text
        var originDict :[String : AnyObject] =
        ["ZXMBM":self.containerViewController!.selectedSubproj!.subprojID! as NSString,
        "SGRQ":self.containerViewController!.dateButton.titleLabel!.text! as NSString,
        "SJD":NODSessionManager.sharedInstance.createStatus!.dayPart! as NSString]
        
        var dict  = Mapper().toJSON(self.containerViewController!.currentPhase!)
        originDict.merge(dict)
        let dictionary  = ["XSG" : originDict]
        let json = JSON(dictionary).rawString(encoding: NSUTF8StringEncoding, options: NSJSONWritingOptions(rawValue: 0))
        println(json)
        self.createNewConstruction(json, completion: { (success) -> () in
            
        })
    }
    
    
    func createNewConstruction(json :String?, completion:(success :Bool)-> ()){
        let user = LoginUser.loadSaved()!

        
        var soapMessage = "<v:Envelope xmlns:i='http://www.w3.org/2001/XMLSchema-instance' xmlns:d='http://www.w3.org/2001/XMLSchema' xmlns:c='http://www.w3.org/2003/05/soap-encoding' xmlns:v='http://www.w3.org/2003/05/soap-envelope'><v:Header /><v:Body><NewTask xmlns='http://tempuri.org/' id='o0' c:root='1'><LoginID i:type='d:string'>\(user.loginId!)</LoginID><SGSC i:type='d:string'>\(json!)</SGSC></NewTask></v:Body></v:Envelope>"
        
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
            SVProgressHUD.showSuccessWithStatus("")
        }, failure: { (operation, error) -> Void in
            
        })
        requestOperation.start()
    }

}
