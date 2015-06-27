//
//  LoginUser.swift
//  NuoDunProject
//
//  Created by lxzhh on 15/6/21.
//  Copyright (c) 2015年 lxzhh. All rights reserved.
//

import UIKit

class LoginUser: NSObject, Mappable, Printable, NSCoding {
    
    var status: Bool?
    var loginCode: String?
    var userName: String?
    var projName: String?
    
    override init(){}
    required init?(_ map: Map) {
        super.init()
        mapping(map)
    }
    
    // Mappable
    func mapping(map: Map) {
        status    <- map["status"]
        loginCode         <- map["DLBM"]
        userName      <- map["FBSMC"]
        projName       <- map["XMMC"]
        
    }
    
   override var description: String {
        get{
            return "status \(status)\n loginCode:\(loginCode)\n userName:\(userName)\n projName:\(projName)"
        }
    }
    
    func saveToPersistance(){
        let data = NSKeyedArchiver.archivedDataWithRootObject(self)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: "loginUser")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    func getStorageUser() -> LoginUser?{
        let data = NSUserDefaults.standardUserDefaults().objectForKey("loginUser") as! NSData
        let user = NSKeyedUnarchiver.unarchiveObjectWithData(data) as! LoginUser
        return user
    }
    
    
    
    @objc required convenience init(coder decoder: NSCoder) {
        self.init()
        self.status = decoder.decodeBoolForKey("status")
        self.loginCode = decoder.decodeObjectForKey("loginCode") as! String?
        self.userName = decoder.decodeObjectForKey("userName") as! String?
        self.projName = decoder.decodeObjectForKey("projName") as! String?
    }
    
    @objc func encodeWithCoder(coder: NSCoder) {
        coder.encodeBool(self.status!, forKey: "status")
        coder.encodeObject(self.loginCode, forKey: "loginCode")
        coder.encodeObject(self.userName, forKey: "userName")
        coder.encodeObject(self.projName, forKey: "projName")

    }
    
    class func loadSaved() -> LoginUser?{
        if let data = NSUserDefaults.standardUserDefaults().objectForKey("loginUser") as? NSData {
            return NSKeyedUnarchiver.unarchiveObjectWithData(data) as? LoginUser
        }
        return nil
    }
}
