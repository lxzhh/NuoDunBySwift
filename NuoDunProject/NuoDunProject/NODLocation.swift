//
//  NODLocation.swift
//  NuoDunProject
//
//  Created by lxzhh on 15/7/13.
//  Copyright (c) 2015年 lxzhh. All rights reserved.
//

import UIKit

class NODLocation: NODObject {
    var locationName : String?
    var locationID : String?
    
    required init?(_ map: Map) {
        super.init()
        mapping(map)
    }
    
    // Mappable
    override func mapping(map: Map) {
        locationName <- map["BWMC"]
        locationID <- map["BWBM"]
    }
    override var description: String {
        get{
            return "locationName:\(locationName) \n  locationID:\(locationID)"
        }
    }
    
    override class func saveKey() -> String?{
        return "NODLocation"
    }
    
    override class func loadJsonRootKey() -> String?{
        return "SGBW"
    }
    
}
