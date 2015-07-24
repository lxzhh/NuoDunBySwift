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
    var detail : NODConstructionDetail?
    
    @IBOutlet weak var locationNameLabel: UILabel!
    
    @IBOutlet weak var subprojNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var mintempLabel: UILabel!
    @IBOutlet weak var workLoadLabel: UILabel!
    @IBOutlet var phaseButtons: [UIButton]!
    
    @IBOutlet weak var workerListLabel: UILabel!
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
            self.detail = detail
            self.locationNameLabel.text = detail?.constructionLocation
            self.subprojNameLabel.text = detail?.subProjName
            self.dateLabel.text = detail?.constructionDate
            self.setDatawithDayPhase(detail?.phase1)
        }
    }
    
    func setDatawithDayPhase(phase : NODConstructionPhase?){
        if(phase != nil){
            maxTempLabel.text = "\(phase!.maxTemp!)°C"
            weatherLabel.text = phase?.weather
            mintempLabel.text = "\(phase!.minTemp!)°C"
            workLoadLabel.text = String(phase!.workLoad!)
        }else{
            maxTempLabel.text = "0°C"
            weatherLabel.text = ""
            mintempLabel.text = "0°C"
            workLoadLabel.text = "无"
        }
        workerListLabel.attributedText = phase?.workerListAttributedString()
    }
  
    @IBAction func switchDayPhase(sender: UIButton) {
        
        phaseButtons.foreach{ $0.selected = false }
        sender.selected = true
        
        switch sender.tag{
        case 100:
            setDatawithDayPhase(detail?.phase1)
        case 101:
            setDatawithDayPhase(detail?.phase2)
        case 102:
            setDatawithDayPhase(detail?.phase3)
        default:
            println()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
