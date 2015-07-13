//
//  NODConstructionDetailController.swift
//  NuoDunProject
//
//  Created by lxzhh on 15/7/5.
//  Copyright (c) 2015年 lxzhh. All rights reserved.
//

import UIKit

class NODConstructionDetailController: UIViewController {
    var constructionDate : String?
    var subProjId : String?
    @IBOutlet weak var locationNameLabel: UILabel!
    
    @IBOutlet weak var subprojNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var mintempLabel: UILabel!
    @IBOutlet weak var workLoadLabel: UILabel!
    @IBOutlet var phaseButtons: [UIButton]!
    
    func revokeProj(){
        let alertView = UIAlertView(title: "提示", message: "是否删除记录", delegate: nil, cancelButtonTitle: "取消")
        alertView.addButtonWithTitle("确定")
        alertView.rac_buttonClickedSignal().subscribeNext { (x) -> Void in
            let number = x as! Int
                
            
        }
        alertView.show()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "施工信息"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "navbar-删除"), style: UIBarButtonItemStyle.Plain, target: self, action:Selector("revokeProj"))
        NODSessionManager.sharedInstance.getContructionDetail(subProjId, constructionDate: constructionDate) { (success, detail) -> () in
            self.locationNameLabel.text = detail?.constructionLocation
            self.subprojNameLabel.text = detail?.subProjName
            self.dateLabel.text = detail?.constructionDate
            self.setDatawithDayPhase(detail?.phase1)
        }
    }
    
    func setDatawithDayPhase(phase : NODConstructionPhase?){
        maxTempLabel.text = "\(phase!.maxTemp!)°C"
        weatherLabel.text = phase?.weather
        mintempLabel.text = "\(phase!.minTemp!)°C"
        workLoadLabel.text = String(phase!.workLoad!)
    }
  
    @IBAction func switchDayPhase(sender: UIButton) {
        
        switch sender.tag{
        case 100:
            println()
        case 101:
            println()
        case 102:
            println()
        default:
            println()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
