//
//  NODGroup.swift
//  NuoDunProject
//
//  Created by lxzhh on 15/7/11.
//  Copyright (c) 2015年 lxzhh. All rights reserved.
//

import UIKit

class NODGroup: NODObject   {
    var groupName : String?
    var groupID : String?
    
    required init?(_ map: Map) {
        super.init()
        mapping(map)
    }
    
    // Mappable
    override func mapping(map: Map) {
        groupName <- map["BZMC"]
        groupID <- map["BZBM"]
    }
    override var description: String {
        get{
            return "groupName:\(groupName) \n  groupID:\(groupID)"
        }
    }
    
    override class func loadJsonRootKey() -> String?{
        return "BZ"
    }
    
}
