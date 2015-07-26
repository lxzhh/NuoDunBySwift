//
//  NODWorkerDetailsController.swift
//  NuoDunProject
//
//  Created by redhat' iMac on 15/7/4.
//  Copyright (c) 2015年 lxzhh. All rights reserved.
//

import UIKit

class NODWorkerDetailsController: UITableViewController {
    var workId : String?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var idNumberLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var contactInfoLabel: UILabel!
    @IBOutlet weak var bankInfoLabel: UILabel!
    @IBOutlet weak var EntryDateLabel: UILabel!
    @IBOutlet weak var basicSalaryLabel: UILabel!
    @IBOutlet weak var dailySalaryLabel: UILabel!
    @IBOutlet weak var bankAccountLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "工人资料"
        NODSessionManager.sharedInstance.getWorkerDetail(workId, completion: { (success, worker : NODWorker?) -> () in
            if(success!){
                self.nameLabel.text = worker?.workerName
                self.groupLabel.text = worker?.workCate
                self.genderLabel.text = worker?.gender
                self.idNumberLabel.text = worker?.identityNumber
                self.originLabel.text = worker?.originPlace
                self.addressLabel.text = worker?.address
                self.contactInfoLabel.text = worker?.telephone
                self.bankInfoLabel.text = worker?.bankName
                self.bankAccountLabel.text = worker?.bankAccount
                self.EntryDateLabel.text = worker?.entryDate
                self.basicSalaryLabel.text = String(format: "￥%.2f", worker!.basicSalary!)
                self.dailySalaryLabel.text = String(format: "￥%.2f", worker!.dailySalary!)
            }
        })
 
    }

    @IBAction func uploadPhoto(sender: AnyObject) {
        let actionSheet =  UIActionSheet(title: "拍照上传", delegate: nil, cancelButtonTitle: "取消", destructiveButtonTitle: nil)
        actionSheet.addButtonWithTitle("个人照片")
        actionSheet.addButtonWithTitle("身份证正面")
        actionSheet.addButtonWithTitle("身份证反面")

        actionSheet.rac_buttonClickedSignal().subscribeNext { (x) -> Void in
            let row = x as! Int
            if row != actionSheet.cancelButtonIndex{
                let imagePicker =  UIImagePickerController()
                imagePicker.rac_imageSelectedSignal().subscribeNext({ (u) -> Void in
                    let userInfo = u as! [String : AnyObject]
                    let image = userInfo[UIImagePickerControllerOriginalImage] as! UIImage
                    self.uploadRequest(image, type: String(row))
                    imagePicker.dismissViewControllerAnimated(true, completion: nil)
                })
                imagePicker.sourceType = .Camera
                self.presentViewController(imagePicker, animated: true, completion: nil)
            }
            
        }
        actionSheet.showInView(self.view.superview)
    }
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    @IBAction func quitJob(sender: AnyObject) {
        let alertView = UIAlertView(title: "提示", message: "是否删除记录", delegate: nil, cancelButtonTitle: "取消")
        alertView.addButtonWithTitle("确定")
        alertView.rac_buttonClickedSignal().subscribeNext { (x) -> Void in
            let number = x as! Int
            if number != alertView.cancelButtonIndex{
                 self.deleteRequest(self.workId)
            }
        }
        alertView.show()
       
    }
    
    func deleteRequest( deletedId : String?){
        
        let user = LoginUser.loadSaved()!
        
        var soapMessage = "<v:Envelope xmlns:i='http://www.w3.org/2001/XMLSchema-instance' xmlns:d='http://www.w3.org/2001/XMLSchema' xmlns:c='http://www.w3.org/2003/05/soap-encoding' xmlns:v='http://www.w3.org/2003/05/soap-envelope'><v:Header /><v:Body><MarkDimission xmlns='http://tempuri.org/' id='o0' c:root='1'><LoginID i:type='d:string'>\(user.loginId!)</LoginID><SFZH  i:type=\"d:string\">\(deletedId!)</SFZH></MarkDimission></v:Body></v:Envelope>"
        
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

    func uploadRequest(image : UIImage, type: String){
        dispatch_async(dispatch_queue_create("", nil
            ), { () -> Void in
                let imageData = UIImageJPEGRepresentation(image, 0.5)
                let base64String = imageData.base64EncodedDataWithOptions(.allZeros)
                let user = LoginUser.loadSaved()!
                
                var soapMessage = "<v:Envelope xmlns:i=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:d=\"http://www.w3.org/2001/XMLSchema\" xmlns:c=\"http://www.w3.org/2003/05/soap-encoding\" xmlns:v=\"http://www.w3.org/2003/05/soap-envelope\"><v:Header /><v:Body><WorkerPhoto xmlns=\"http://tempuri.org/\" id=\"o0\" c:root=\"1\"><IMGInBase64 i:type=\"d:string\">\(base64String)</IMGInBase64><SFZH i:type=\"d:string\">\(user.loginId!)</SFZH><PType i:type=\"d:string\">0</PType></WorkerPhoto></v:Body></v:Envelope>"
                
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
                        SVProgressHUD.showSuccessWithStatus("成功上传")
                        //                self.navigationController?.popViewControllerAnimated(true)
                    }
                    
                    }, failure: { (operation, error) -> Void in
                        SVProgressHUD.showErrorWithStatus("上传失败")
                })
                requestOperation.start()
        })
        
        
    }
    
}
