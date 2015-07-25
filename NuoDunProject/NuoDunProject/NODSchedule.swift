//
//  NODSchedule.swift
//  NuoDunProject
//
//  Created by 乐星宇 on 15/7/25.
//  Copyright (c) 2015年 lxzhh. All rights reserved.
//

import UIKit

class NODSchedule: NSObject ,Mappable, Printable{
    var subprojID : Int?
    var subprojName : String?
    var projLocation : String?
    var projLoad : Float?
    var startDate : String?
    var endDate : String?
    var completedPercent : Float?
    var changeCode : String?
    override init(){}
    required init?(_ map: Map) {
        super.init()
        mapping(map)
    }
    
    // Mappable
    func mapping(map: Map) {
        subprojID <- map["ZXMBM"]
        subprojName <- map["ZXMMC"]
        projLocation <- map["BWMC"]
        projLoad <- map["FBGCL"]
        startDate <- map["JHKSRQ"]
        endDate <- map["JHJSRQ"]
        completedPercent <- map["WCBL"]
        changeCode <- map["BGBM"]
    }
    override var description: String {
        get{
            return "completedPercent:\(completedPercent) \n  subprojName:\(subprojName) \n "
        }
    }

}
