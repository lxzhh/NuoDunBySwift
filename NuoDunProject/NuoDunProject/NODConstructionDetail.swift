//
//  NODConstructionDetail.swift
//  NuoDunProject
//
//  Created by lxzhh on 15/7/5.
//  Copyright (c) 2015年 lxzhh. All rights reserved.
//

import UIKit

class NODConstructionPhase: NSObject,Mappable, Printable{
    var weather : String?
    var workLoad : Int?
    var maxTemp : String?
    var minTemp : String?
    var people : Array<NODWorker>?
   
    override init(){}
    required init?(_ map: Map) {
        super.init()
        mapping(map)
    }
    
    // Mappable
    func mapping(map: Map) {
        weather <- map["TQMC"]
        workLoad <- map["WCGCL"]
        maxTemp <- map["ZGQW"]
        minTemp <- map["ZDQW"]
        people <- map["GR"]
    }
    override var description: String {
        get{
            return "weather:\(weather) \n  workLoad:\(workLoad) \n people :\(people)"
        }
    }
}

class NODConstructionDetail: NSObject,Mappable, Printable {
    var status : Bool?
    var constructionLocation : String?
    var constructionDate : String?
    var subProjName : String?
    var phase1 : NODConstructionPhase?
    var phase2 : NODConstructionPhase?
    var phase3 : NODConstructionPhase?

    override init(){}
    required init?(_ map: Map) {
        super.init()
        mapping(map)
    }
    
    // Mappable
    func mapping(map: Map) {
        status <- map["status"]
        constructionLocation <- map["BWMC"]
        constructionDate <- map["SGRQ"]
        subProjName <- map["ZXMMC"]
        phase1 <- map["SJD01"]
        phase2 <- map["SJD02"]
        phase3 <- map["SJD03"]
    }
    override var description: String {
        get{
            return "subProjName:\(subProjName) \n  constructionLocation:\(constructionLocation) \n phase1:\(phase1)"
        }
    }
}
