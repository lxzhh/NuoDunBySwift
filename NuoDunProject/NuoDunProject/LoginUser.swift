//
//  LoginUser.swift
//  NuoDunProject
//
//  Created by lxzhh on 15/6/21.
//  Copyright (c) 2015年 lxzhh. All rights reserved.
//

import UIKit

class LoginUser: Mappable, Printable {
    
    var status: Bool?
    var loginCode: String?
    var companyName: String?
    var projName: String?
    
    required init?(_ map: Map) {
        mapping(map)
    }
    
    // Mappable
    func mapping(map: Map) {
        status    <- map["status"]
        loginCode         <- map["DLBM"]
        companyName      <- map["FBSMC"]
        projName       <- map["XMMC"]
        
    }
    
    var description: String {
        get{
            return "status \(status), loginCode:\(loginCode), companyName:\(companyName),projName:\(projName)"
        } }

}
