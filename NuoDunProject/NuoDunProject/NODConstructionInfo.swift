//
//  NODConstructionInfo.swift
//  NuoDunProject
//
//  Created by lxzhh on 15/7/5.
//  Copyright (c) 2015年 lxzhh. All rights reserved.
//

import UIKit

class NODConstructionInfo: NSObject,Mappable, Printable  {
    var constructionDate : String?
    var subProjId : String?
    var constructionGroup : String?
    var subProjName : String?
   
    var alreadyPayed : Int?
    var workload1 : Float? = 0
    var workload2 : Float? = 0
    var workload3 : Float? = 0
    override init(){}
    required init?(_ map: Map) {
        super.init()
        mapping(map)
    }
    
    // Mappable
    func mapping(map: Map) {
        constructionDate <- map["SGRQ"]
        constructionGroup <- map["BWMC"]
        subProjName <- map["ZXMMC"]
        subProjId <- map["ZXMBM"]
        workload1 <- map["SJD01_WCGCL"]
        workload2 <- map["SJD02_WCGCL"]
        workload3 <- map["SJD03_WCGCL"]
    }
    override var description: String {
        get{
            return "subProjId:\(subProjId) \n  subProjName:\(subProjName)"
        }
    }
}
