//
//  NODSessionManager.swift
//  
//
//  Created by lxzhh on 15/6/20.
//
//

import UIKit

let urlString :String  = "http://115.231.54.166:9090/jobrecordapp.asmx"

class NODSessionManager: AFHTTPSessionManager {
    class var sharedInstance: NODSessionManager {
        struct Static {
//            let configure :NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
//            configure.response
            static let instance: NODSessionManager = NODSessionManager(baseURL: NSURL(string:urlString))
        }
        Static.instance.responseSerializer = AFHTTPResponseSerializer()

        return Static.instance
    }
   
    func login(name : String, password : String, completion: (Bool) -> ()){
        self.GET("APPLogin", parameters:["LoginID":name,"MM":password], success: { (session: NSURLSessionDataTask!,responseObject: AnyObject!) -> Void in
            
            let data = responseObject as! NSData
            let xml = SWXMLHash.parse(data)
            let resultString :String? = xml["string"].element?.text
            let user  = Mapper<LoginUser>().map(resultString!)
            user?.loginId = name
            println("resultString:\(resultString) user \(user)")
            if (user!.loginCode! == "1"){
                user?.saveToPersistance()
                completion(true)
            }
            
            },
            failure :{ (session: NSURLSessionDataTask!,error: NSError!) -> Void in
                println(error)
        })
    }
    
    func finacialInfoList(completion : (supposeToPay :Int?, alreadyPayed :Int?, unpaid :Int?, success :Bool?, list :Array<NODFinacialInfo>?) -> ()){
        let user = LoginUser.loadSaved()!
        self.GET("DisplayWorkSalaryTotal", parameters:["LoginID":user.loginId!], success: { (session: NSURLSessionDataTask!,responseObject: AnyObject!) -> Void in
            let data = responseObject as! NSData
            let xml = SWXMLHash.parse(data)
            let resultString :String? = xml["string"].element?.text
            let jdata: NSData = resultString!.dataUsingEncoding(NSUTF8StringEncoding)!
            let error : NSErrorPointer;
            let json  = JSON(data: jdata)
            let infoList  = Mapper<NODFinacialInfo>().mapArray(json["XZMR"].arrayObject)
            println("resultString :\(resultString) json :\(json) infoList \(infoList)")
            if ((infoList) != nil){
                completion(supposeToPay: json["XZZE"]["YFZE"].int,
                            alreadyPayed: json["XZZE"]["SFZE"].int,
                            unpaid: json["XZZE"]["YFYE"].int,
                            success: true,
                            list:infoList)
            }
            },
            failure :{ (session: NSURLSessionDataTask!,error: NSError!) -> Void in
                println(error)
        })
    }
    
    
    func personalFinacialInfoList(userId :String?, completion : (date :String?, supposeToPay :String?, alreadyPayed :String?, unpaid :String?, success :Bool?, list :Array<NODFinacialInfo>?) -> ()){
        let user = LoginUser.loadSaved()!
        self.GET("DisplaySingleWorkSalaryInMonths",
            parameters:["LoginID":user.loginId!,
                           "SFZH":userId ?? ""],
            success: { (session: NSURLSessionDataTask!,responseObject: AnyObject!) -> Void in
            let data = responseObject as! NSData
            let xml = SWXMLHash.parse(data)
            let resultString :String? = xml["string"].element?.text
            let jdata: NSData = resultString!.dataUsingEncoding(NSUTF8StringEncoding)!
            let error : NSErrorPointer;
            let json  = JSON(data: jdata)
            let infoList  = Mapper<NODFinacialInfo>().mapArray(json["GRYF"].arrayObject)
            println("resultString :\(resultString) json :\(json) infoList \(infoList)")
            let formatter = NSDateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let date = formatter.dateFromString( json["RZRQ"].stringValue)
         
            if ((infoList) != nil){
                completion(date: json["RZRQ"].string,
                    supposeToPay: json["GRZE"]["YFZE"].string,
                    alreadyPayed: json["GRZE"]["SFZE"].string,
                    unpaid: json["GRZE"]["YFYE"].string,
                    success: true,
                    list:infoList)
            }
            },
            failure :{ (session: NSURLSessionDataTask!,error: NSError!) -> Void in
                println(error)
        })
    }
    
    func labourInfoList(completion : (success :Bool?, list :Array<NODLabourCategory>?) -> ()){
        let user = LoginUser.loadSaved()!
        self.GET("BrowseWorkerByGroup",
            parameters:["LoginID":user.loginId!],
            success: { (session: NSURLSessionDataTask!,responseObject: AnyObject!) -> Void in
                let data = responseObject as! NSData
                let xml = SWXMLHash.parse(data)
                let resultString :String? = xml["string"].element?.text
                let jdata: NSData = resultString!.dataUsingEncoding(NSUTF8StringEncoding)!
                let error : NSErrorPointer;
                let json  = JSON(data: jdata)
                let infoList  = Mapper<NODLabourCategory>().mapArray(json["LW"].arrayObject)
                println("resultString :\(resultString) json :\(json) infoList \(infoList)") 
                if ((infoList) != nil){
                    completion(success: true,
                                list:infoList)
                }
            },
            failure :{ (session: NSURLSessionDataTask!,error: NSError!) -> Void in
                println(error)
        })
    }
    
    func getWorkerDetail(workerId :String?,completion : (success :Bool?, worker : NODWorker?) -> ()){
        let user = LoginUser.loadSaved()!
        self.GET("BrowseWorkerDetails",
            parameters:["LoginID":user.loginId!,
                           "SFZH":workerId ?? ""],
            success: { (session: NSURLSessionDataTask!,responseObject: AnyObject!) -> Void in
                let data = responseObject as! NSData
                let xml = SWXMLHash.parse(data)
                let resultString :String? = xml["string"].element?.text
                let worker  = Mapper<NODWorker>().map(resultString!)
                println("resultString :\(resultString) \n worker \(worker)")
                    completion(success: true,
                        worker:worker)
           
            },
            failure :{ (session: NSURLSessionDataTask!,error: NSError!) -> Void in
                println(error)
        })
    }
    
    
    
    func getContructionList(weekOffset : Int?, completion : (success :Bool?, list :Array<NODConstructionInfo>?) -> ()){
        let user = LoginUser.loadSaved()!
        self.GET("DisplayWorkLoadInWeek",
            parameters:["LoginID":user.loginId!,
                "XMZXH":weekOffset ?? 0],
            success: { (session: NSURLSessionDataTask!,responseObject: AnyObject!) -> Void in
                let data = responseObject as! NSData
                let xml = SWXMLHash.parse(data)
                let resultString :String? = xml["string"].element?.text
                let jdata: NSData = resultString!.dataUsingEncoding(NSUTF8StringEncoding)!
                let error : NSErrorPointer;
                let json  = JSON(data: jdata)
                let infoList  = Mapper<NODConstructionInfo>().mapArray(json["XM"].arrayObject)
                println("resultString :\(resultString) \n ")
                completion(success: true,
                    list: infoList)
                
            },
            failure :{ (session: NSURLSessionDataTask!,error: NSError!) -> Void in
                println(error)
        })
    }
    
    func getContructionDetail(subprojId : String?, constructionDate :String?, completion : (success :Bool?, detail :NODConstructionDetail?) -> ()){
        let user = LoginUser.loadSaved()!
        self.GET("DisplayWorkInDay",
            parameters:["ZXMBM":subprojId!,
                "SGRQ":constructionDate!],
            success: { (session: NSURLSessionDataTask!,responseObject: AnyObject!) -> Void in
                let data = responseObject as! NSData
                let xml = SWXMLHash.parse(data)
                let resultString :String? = xml["string"].element?.text
//                let jdata: NSData = resultString!.dataUsingEncoding(NSUTF8StringEncoding)!
//                let error : NSErrorPointer;
//                let json  = JSON(data: jdata)
                let detail  = Mapper<NODConstructionDetail>().map(resultString!)
                println("resultString :\(resultString) \n detail:\(detail)")
                completion(success: true,
                    detail: detail)
                
            },
            failure :{ (session: NSURLSessionDataTask!,error: NSError!) -> Void in
                println(error)
        })
    }
    
    
    /**
        revokeProj
    */
    func revokeProj(subprojCode : String?, completion : (success :Bool?, detail :NODConstructionDetail?) -> ()){
        let user = LoginUser.loadSaved()!
        self.GET("RevokeNewTask",
            parameters:["LoginID":user.loginId!,
                        "SGXH":subprojCode!],
            success: { (session: NSURLSessionDataTask!,responseObject: AnyObject!) -> Void in
                let data = responseObject as! NSData
                let xml = SWXMLHash.parse(data)
                let resultString :String? = xml["string"].element?.text
                //                let jdata: NSData = resultString!.dataUsingEncoding(NSUTF8StringEncoding)!
                //                let error : NSErrorPointer;
                //                let json  = JSON(data: jdata)
                let detail  = Mapper<NODConstructionDetail>().map(resultString!)
                println("resultString :\(resultString) \n detail:\(detail)")
                completion(success: true,
                    detail: detail)
                
            },
            failure :{ (session: NSURLSessionDataTask!,error: NSError!) -> Void in
                println(error)
        })
    }
    
}
