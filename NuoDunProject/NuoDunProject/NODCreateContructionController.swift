//
//  NODCreateContructionController.swift
//  NuoDunProject
//
//  Created by lxzhh on 15/7/19.
//  Copyright (c) 2015年 lxzhh. All rights reserved.
//

import UIKit

class NODCreateContructionController: UITableViewController {

    @IBOutlet weak var contructionLocationLabel: UITextField!
    
    @IBOutlet weak var subprojNameLabbel: UITextField!
    @IBOutlet weak var dateButton: UIButton!
    
    @IBOutlet weak var maxTemp: UITextField!
    
    @IBOutlet weak var minTemp: UITextField!
    @IBOutlet weak var labourLoadField: UITextField!
    
    @IBOutlet weak var weatherButton: UIButton!
    @IBOutlet var phaseButtons: [UIButton]!
    
    var selectedLocation : NODLocation?
    var subProjList : [NODSubproj]?
    var selectedSubproj : NODSubproj?
    
    var phase1 : NODConstructionPhase? = NODConstructionPhase()
    var phase2 : NODConstructionPhase? = NODConstructionPhase()
    var phase3 : NODConstructionPhase? = NODConstructionPhase()
    var parentVC : NODCreateConstructionContainerController?
    
    
    var currentPhase : NODConstructionPhase? = NODConstructionPhase()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerNib(UINib(nibName: "NODAddObjectCell", bundle: nil), forCellReuseIdentifier: "AddObject")
        let status = NODSessionManager.sharedInstance.createStatus
        self.dateButton.setTitle(status?.currentDate, forState: UIControlState.Normal)
        if let s = status{
            switch s.dayPart! {
            case "01":
                currentPhase = phase1
                phaseButtons[0].selected = true
            case "02":
                currentPhase = phase2
                phaseButtons[1].selected = true

            case "03":
                currentPhase = phase3
                phaseButtons[2].selected = true

            default:
                println()
            }
        }
        let locationList = NODLocation.loadSavedJson(NODLocation.self)
        self.selectedLocation = locationList![0]
        self.contructionLocationLabel.text = selectedLocation?.locationName
        let subProjList = NODSubproj.loadSavedJson(NODSubproj.self)
        let subList = subProjList?.filter{ (p : NODSubproj) -> Bool in
            return p.locationId == self.selectedLocation?.locationID
        }
        self.selectedSubproj = subList![0]
        subprojNameLabbel.text = selectedSubproj?.subprojName
        self.maxTemp.rac_signalForControlEvents(UIControlEvents.EditingDidEnd).subscribeNext { (x) -> Void in
            let field = x as! UITextField
            self.currentPhase?.maxTemp = field.text
        }
        self.minTemp.rac_signalForControlEvents(UIControlEvents.EditingDidEnd).subscribeNext { (x) -> Void in
            let field = x as! UITextField
            self.currentPhase?.minTemp = field.text
        }
        self.labourLoadField.rac_signalForControlEvents(UIControlEvents.EditingDidEnd).subscribeNext { (x) -> Void in
            let field = x as! UITextField
            self.currentPhase?.workLoad = field.text.toInt()
        }
        
        self.contructionLocationLabel.rac_signalForControlEvents(UIControlEvents.EditingDidBegin).subscribeNext { (x) -> Void in
            let field = x as! UITextField
            let rows = locationList!.map{ (t : NODLocation) -> String! in
                return t.locationName!
            }
            let picker = ActionSheetStringPicker(title: "位置", rows: rows, initialSelection: 0, doneBlock: { (picker, index, o) -> Void in
                field.text = o as! String
                self.selectedLocation = locationList![index]
                }, cancelBlock: { (picker) -> Void in
                    
                }, origin: field)
            picker.showActionSheetPicker()
        }
        self.subprojNameLabbel.rac_signalForControlEvents(UIControlEvents.EditingDidBegin).subscribeNext { (x) -> Void in
            let field = x as! UITextField
            let subList = subProjList?.filter{ (p : NODSubproj) -> Bool in
                return p.locationId == self.selectedLocation?.locationID
            }
            let rows = subList!.map{ (t : NODSubproj) -> String! in
                return t.subprojName!
            }
            self.selectedSubproj = subList![0]
            let picker = ActionSheetStringPicker(title: "子项目", rows: rows, initialSelection: 0, doneBlock: { (picker, index, o) -> Void in
                field.text = o as! String
                self.selectedSubproj = subList![index]
                }, cancelBlock: { (picker) -> Void in
                    
                }, origin: field)
            picker.showActionSheetPicker()
        }
        
    }

    func reloadPhaseData(){
        weatherButton.setTitle(self.currentPhase?.weather, forState: UIControlState.Normal)
        maxTemp.text = currentPhase?.maxTemp
        minTemp.text = currentPhase?.minTemp
        labourLoadField.text = String(currentPhase!.workLoad!)

    }
    
    @IBAction func phaseSwitch(sender: UIButton) {
        return;
            
        self.view.endEditing(true)
        
        phaseButtons.foreach{ $0.selected = false }
        sender.selected = true
        let parentVC = self.parentViewController as! NODCreateConstructionContainerController
        switch sender.tag{
        case 100:
            currentPhase = phase1
        case 101:
            currentPhase = phase2
        case 102:
            currentPhase = phase3
        default:
            println()
        }
        self.reloadPhaseData()
        parentVC.tableView.reloadData()
    }
    
    @IBAction func weatherSelect(sender: AnyObject) {
        let rows = NODWeather.loadSavedJson(NODWeather.self)
        let names = (rows! as NSArray).valueForKey("weatherName") as! Array<String>
        let picker = ActionSheetStringPicker(title: "天气", rows:names , initialSelection: 0, doneBlock: { (picker, index, o ) -> Void in
            self.weatherButton.setTitle(o as? String, forState: UIControlState.Normal)
            self.currentPhase?.weather = rows?[index].weatherName
            self.currentPhase?.weatherID = rows?[index].weatherID
            }, cancelBlock: { (picker) -> Void in
                
            }, origin: sender)
        picker.showActionSheetPicker()
    }
    
    
    
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return super.numberOfSectionsInTableView(tableView)
    }

    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return super.tableView(tableView, numberOfRowsInSection: section)
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        return super.tableView(tableView, cellForRowAtIndexPath: indexPath)
    }
    override func tableView(tableView: UITableView, indentationLevelForRowAtIndexPath indexPath: NSIndexPath) -> Int {
        return super.tableView(tableView,indentationLevelForRowAtIndexPath:indexPath)
    }
    

}
