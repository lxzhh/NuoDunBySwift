//
//  NODWeather.swift
//  NuoDunProject
//
//  Created by 乐星宇 on 15/7/13.
//  Copyright (c) 2015年 lxzhh. All rights reserved.
//

import UIKit

class NODWeather: NODObject  {
    var weatherName : String?
    var weatherID : String?
    
    required init?(_ map: Map) {
        super.init()
        mapping(map)
    }
    
    // Mappable
    override func mapping(map: Map) {
        weatherName <- map["TQMC"]
        weatherID <- map["TQBM"]
        
    }
    override var description: String {
        get{
            return "weatherName:\(weatherName) \n  weatherID:\(weatherID)"
        }
    }
    
    override class func saveKey() -> String?{
        return "NODWeather"
    }
    
    override class func loadJsonRootKey() -> String?{
        return "TQ"
    }
}
