//
//  NODStatues.swift
//  NuoDunProject
//
//  Created by lxzhh on 15/7/20.
//  Copyright (c) 2015年 lxzhh. All rights reserved.
//

import UIKit

class NODStatus: NSObject,Mappable, Printable  {
    var status : Bool?
    var currentDate : String?
    var dayPart : String?
 
    override init(){}
    required init?(_ map: Map) {
        super.init()
        mapping(map)
    }
    
    // Mappable
    func mapping(map: Map) {
        status <- map["status"]
        currentDate <- map["RQ"]
        dayPart <- map["SJD"]
      
    }
    override var description: String {
        get{
            return "status:\(status) \n  currentDate:\(currentDate)"
        }
    }
}
