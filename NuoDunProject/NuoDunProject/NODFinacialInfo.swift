//
//  NODFinacialList.swift
//  NuoDunProject
//
//  Created by redhat' iMac on 15/7/4.
//  Copyright (c) 2015年 lxzhh. All rights reserved.
//

import UIKit


class NODFinacialInfo: NSObject,Mappable, Printable {
    
    var userName : String?
    var userID : String?
    var dateString : String?
    var supposeToPay : Int?
    var alreadyPayed : Int?
    var unpaid : Int?
    override init(){}
    required init?(_ map: Map) {
        super.init()
        mapping(map)
    }
    // Mappable
    func mapping(map: Map) {
        userName <- map["XM"]
        userID <- map["SFZH"]
        supposeToPay <- map["YFZE"]
        alreadyPayed <- map["SFZE"]
        unpaid <- map["YFYE"]
        dateString <- map["GZYF"]
    }
    override var description: String {
        get{
            return "userName:\(userName) \n  userID:\(userID)"
        }
    }
}
