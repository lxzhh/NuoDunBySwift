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
    
    func deleteRequest( deletedId : String?){
        
        let user = LoginUser.loadSaved()!
        
        var soapMessage = "<v:Envelope xmlns:i='http://www.w3.org/2001/XMLSchema-instance' xmlns:d='http://www.w3.org/2001/XMLSchema' xmlns:c='http://www.w3.org/2003/05/soap-encoding' xmlns:v='http://www.w3.org/2003/05/soap-envelope'><v:Header /><v:Body><RevokeNewTask xmlns='http://tempuri.org/' id='o0' c:root='1'><LoginID i:type='d:string'>\(user.loginId!)</LoginID><SGXH  i:type=\"d:string\">\(deletedId!)</SGXH></RevokeNewTask></v:Body></v:Envelope>"
        
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
            SVProgressHUD.showSuccessWithStatus("成功删除")
            self.navigationController?.popViewControllerAnimated(true)
            }, failure: { (operation, error) -> Void in
                SVProgressHUD.showErrorWithStatus("删除失败")
        })
        requestOperation.start()
        
    }
    
    func revokeProj(){
        let alertView = UIAlertView(title: "提示", message: "是否删除记录", delegate: nil, cancelButtonTitle: "取消")
        alertView.addButtonWithTitle("确定")
        alertView.rac_buttonClickedSignal().subscribeNext { (x) -> Void in
            let number = x as! Int
            if number != alertView.cancelButtonIndex{
                self.deleteRequest(self.subProjId)
            }
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
