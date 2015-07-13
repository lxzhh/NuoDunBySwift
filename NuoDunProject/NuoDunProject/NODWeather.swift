//
//  NODWeather.swift
//  NuoDunProject
//
//  Created by 乐星宇 on 15/7/13.
//  Copyright (c) 2015年 lxzhh. All rights reserved.
//

import UIKit

class NODWeather: NODObject  {
    var subprojName : String?
    var subprojID : String?
    var locationId : String?
    
    required init?(_ map: Map) {
        super.init()
        mapping(map)
    }
    
    // Mappable
    override func mapping(map: Map) {
        subprojName <- map["ZXMMC"]
        subprojID <- map["ZXMBM"]
        locationId <- map["BWBM"]
        
    }
    override var description: String {
        get{
            return "subprojName:\(subprojName) \n  subprojID:\(subprojID)"
        }
    }
    
    override class func loadJsonRootKey() -> String?{
        return "BZ"
    }
}
