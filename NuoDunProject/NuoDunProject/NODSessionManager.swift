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
                NSNotificationCenter.defaultCenter().postNotificationName("loginNotification", object: nil)
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
    
    
    
    func QueryGroup(completion : (success : Bool, groups: Array<NODGroup>?)->()){
        self.GET("QueryGroup",
            parameters:nil,
            success: { (session: NSURLSessionDataTask!,responseObject: AnyObject!) -> Void in
                let data = responseObject as! NSData
                let xml = SWXMLHash.parse(data)
                let resultString :String? = xml["string"].element?.text
                NODGroup.saveToLocal(resultString!)
                let jdata: NSData = resultString!.dataUsingEncoding(NSUTF8StringEncoding)!
                let error : NSErrorPointer;
                let json  = JSON(data: jdata)
                let groups  = json.arrayObject as! [NODGroup]?
                println("QueryGroup resultString :\(resultString) \n detail:\(groups)")
                completion(success: true,
                    groups: groups)
                
            },
            failure :{ (session: NSURLSessionDataTask!,error: NSError!) -> Void in
                println(error)
        })
    }
    
    
    func createNewWorker(worker :NODWorker, completion:(success :Bool)-> ()){
        let user = LoginUser.loadSaved()!
        let mapper = Mapper().toJSONString(worker, prettyPrint: false)
        let dictionary  = ["XGR" : mapper!]
        let json = JSON(dictionary).rawString(encoding: NSUTF8StringEncoding, options: NSJSONWritingOptions(rawValue: 0))
        
        let postString =  "<v:Envelope xmlns:i=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:d=\"http://www.w3.org/2001/XMLSchema\" xmlns:c=\"http://www.w3.org/2003/05/soap-encoding\" xmlns:v=\"http://www.w3.org/2003/05/soap-envelope\"><v:Header /><v:Body><NewWorker xmlns=\"http://tempuri.org/\" id=\"o0\" c:root=\"1\"><LoginID i:type=\"d:string\">\(user.loginId!)</LoginID><GRSC i:type=\"d:string\">\(json)</GRSC></NewWorker></v:Body></v:Envelope>"
        println("create new worker \(worker) theJSONText:\(json!)")
        self.POST("NewWorker", parameters:postString, success: { (session: NSURLSessionDataTask!, response :AnyObject!) -> Void in
            
            }, failure :{ (session: NSURLSessionDataTask!,error: NSError!) -> Void in
            println(error)
        })
    }
    
    func QueryLocation(completion : ((success : Bool, locations: Array<NODLocation>?)->())? ){
        self.GET("QueryLocation",
            parameters:["LoginID":LoginUser.loadSaved()!.loginId!],
            success: { (session: NSURLSessionDataTask!,responseObject: AnyObject!) -> Void in
                let data = responseObject as! NSData
                let xml = SWXMLHash.parse(data)
                let resultString :String? = xml["string"].element?.text
                NODLocation.saveToLocal(resultString!)
                let jdata: NSData = resultString!.dataUsingEncoding(NSUTF8StringEncoding)!
                let error : NSErrorPointer;
                let json  = JSON(data: jdata)
                let groups  = json.arrayObject as! [NODLocation]?
                println("QueryGroup resultString :\(resultString) \n detail:\(groups)")
                completion?(success: true,
                    locations: groups)
                
            },
            failure :{ (session: NSURLSessionDataTask!,error: NSError!) -> Void in
                println(error)
        })
    }
    func QuerySubproj(completion : (success : Bool, groups: Array<NODSubproj>?)->()){
        self.GET("QuerySubProject",
            parameters:["LoginID":LoginUser.loadSaved()!.loginId!],
            success: { (session: NSURLSessionDataTask!,responseObject: AnyObject!) -> Void in
                let data = responseObject as! NSData
                let xml = SWXMLHash.parse(data)
                let resultString :String? = xml["string"].element?.text
                NODSubproj.saveToLocal(resultString!)
                let jdata: NSData = resultString!.dataUsingEncoding(NSUTF8StringEncoding)!
                let error : NSErrorPointer;
                let json  = JSON(data: jdata)
                let groups  = json.arrayObject as! [NODSubproj]?
                println("QueryGroup resultString :\(resultString) \n detail:\(groups)")
                completion(success: true,
                    groups: groups)
                
            },
            failure :{ (session: NSURLSessionDataTask!,error: NSError!) -> Void in
                println(error)
        })
    }
    
    func QueryWeather(completion : ((success : Bool, weatherList: Array<NODWeather>?)->())?){
        self.GET("QueryWeather",
            parameters:nil,
            success: { (session: NSURLSessionDataTask!,responseObject: AnyObject!) -> Void in
                let data = responseObject as! NSData
                let xml = SWXMLHash.parse(data)
                let resultString :String? = xml["string"].element?.text
                NODWeather.saveToLocal(resultString!)
                let jdata: NSData = resultString!.dataUsingEncoding(NSUTF8StringEncoding)!
                let error : NSErrorPointer;
                let json  = JSON(data: jdata)
                let groups  = json.arrayObject as! [NODWeather]?
                println("QueryGroup resultString :\(resultString) \n detail:\(groups)")
                completion?(success: true,
                    weatherList: groups)
                
            },
            failure :{ (session: NSURLSessionDataTask!,error: NSError!) -> Void in
                println(error)
        })
    }
    func QueryMachine(completion : ((success : Bool, groups: Array<NODMachine>?)->())? ){
        self.GET("QueryMachine",
            parameters:["LoginID":LoginUser.loadSaved()!.loginId!],
            success: { (session: NSURLSessionDataTask!,responseObject: AnyObject!) -> Void in
                let data = responseObject as! NSData
                let xml = SWXMLHash.parse(data)
                let resultString :String? = xml["string"].element?.text
                NODMachine.saveToLocal(resultString!)
                let jdata: NSData = resultString!.dataUsingEncoding(NSUTF8StringEncoding)!
                let error : NSErrorPointer;
                let json  = JSON(data: jdata)
                let groups  = json.arrayObject as! [NODMachine]?
                println("QueryGroup resultString :\(resultString) \n detail:\(groups)")
                completion?(success: true,
                    groups: groups)
                
            },
            failure :{ (session: NSURLSessionDataTask!,error: NSError!) -> Void in
                println(error)
        })
    }
    func QueryMaterial(completion : ((success : Bool, groups: Array<NODMaterial>?)->())? ){
        self.GET("QueryMaterial",
            parameters:["LoginID":LoginUser.loadSaved()!.loginId!],
            success: { (session: NSURLSessionDataTask!,responseObject: AnyObject!) -> Void in
                let data = responseObject as! NSData
                let xml = SWXMLHash.parse(data)
                let resultString :String? = xml["string"].element?.text
                NODMaterial.saveToLocal(resultString!)
                let jdata: NSData = resultString!.dataUsingEncoding(NSUTF8StringEncoding)!
                let error : NSErrorPointer;
                let json  = JSON(data: jdata)
                let groups  = json.arrayObject as! [NODMaterial]?
                println("QueryGroup resultString :\(resultString) \n detail:\(groups)")
                completion?(success: true,
                    groups: groups)
                
            },
            failure :{ (session: NSURLSessionDataTask!,error: NSError!) -> Void in
                println(error)
        })
    }
    
    
    func queryEverything(){
        self.QueryLocation(nil)
        self.QueryMachine(nil)
        self.QueryMaterial(nil)
    }
}