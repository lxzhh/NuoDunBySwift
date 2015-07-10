//
//  NODFinacialList.swift
//  NuoDunProject
//
//  Created by redhat' iMac on 15/7/4.
//  Copyright (c) 2015年 lxzhh. All rights reserved.
//

import UIKit

class NODFinacialInfo: NSObject, Mappable, Printable  {
    var supposeToPay :Int?
    var alreadyPayed :Int?
    var unpaid :Int?
    var userID :String?
    var userName :String?
    var dateString :String?
    override init(){}
    required init?(_ map: Map) {
        super.init()
        mapping(map)
    }
    
    // Mappable
    func mapping(map: Map) {
        supposeToPay    <- map["YFZE"]
        alreadyPayed    <- map["SFZE"]
        unpaid          <- map["YFYE"]
        userID          <- map["SFZH"]
        userName        <- map["XM"]
        dateString      <- map["GZYF"]
    }
    
    override var description: String {
        get{
            return "userID \(userID) userName \(userName) supposeToPay \(supposeToPay)\n alreadyPayed:\(alreadyPayed)\n unpaid:\(unpaid)\n "
        }
    }
}
