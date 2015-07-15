//
//  NODMachine.swift
//  NuoDunProject
//
//  Created by lxzhh on 15/7/14.
//  Copyright (c) 2015年 lxzhh. All rights reserved.
//

import UIKit

class NODMachine: NODObject {
    var machineName : String?
    var machineID : String?
    
    required init?(_ map: Map) {
        super.init()
        mapping(map)
    }
    
    // Mappable
    override func mapping(map: Map) {
        machineName <- map["JJMC"]
        machineID <- map["JJBM"]
        
    }
    override var description: String {
        get{
            return "machineName:\(machineName) \n  machineID:\(machineID)"
        }
    }
    
    override class func loadJsonRootKey() -> String?{
        return "JJ"
    }
}
