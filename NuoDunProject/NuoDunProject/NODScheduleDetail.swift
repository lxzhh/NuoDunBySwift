//
//  NODScheduleDetail.swift
//  NuoDunProject
//
//  Created by 乐星宇 on 15/7/25.
//  Copyright (c) 2015年 lxzhh. All rights reserved.
//

import UIKit

class NODScheduleDetail: NSObject,Mappable, Printable {
    
    var projLoad : Int?
    var completedLoad : Int?
    var changeCode : String?
    var supposeToPay : Int?
    var workDuration : String?
    var loadPerDay : String?
    var startDate : String?
    var contractPrice : Int?
    var contractSumPrice : Int?
    var endDate : String?
    var completedPercentage : Float?
    var actualStartDate : String?
    var actualEndDate : String?
    
    override init(){}
    required init?(_ map: Map) {
        super.init()
        mapping(map)
    }
    // Mappable
    func mapping(map: Map) {
        projLoad <- map["FBGCL"]
        completedLoad <- map["WCGCL"]
        changeCode <- map["BGBM"]
        workDuration <- map["GQ"]
        loadPerDay <- map["RJGCL"]
        startDate <- map["JHKSRQ"]
        contractPrice <- map["HTDJ"]
        contractSumPrice <- map["HTZJ"]
        endDate <- map["JHJSRQ"]
        completedPercentage <- map["WCBL"]
        actualStartDate <- map["SJKSRQ"]
        actualEndDate <- map["SJJSRQ"]
    }
    override var description: String {
        get{
            return "workDuration:\(workDuration) \n  contractPrice:\(contractPrice)"
        }
    }
}
