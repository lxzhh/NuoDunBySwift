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
    var weatherID : String?

    var workLoad : Int? = 0
    var maxTemp : String?
    var minTemp : String?
    var machineList : [NODMachine]? = []
    var materialList : [NODMaterial]? = []
    var workerList : [NODLabour]? = []
    
    
    override init(){}
    required init?(_ map: Map) {
        super.init()
        mapping(map)
    }
    
    // Mappable
    func mapping(map: Map) {
        weather <- map["TQMC"]
        weatherID <- map["TQBM"]
        workLoad <- map["WCGCL"]
        maxTemp <- map["ZGQW"]
        minTemp <- map["ZDQW"]
        workerList <- map["GR"]
        materialList <- map["CL"]
        machineList <- map["JJ"]
    }
    
    func workerListAttributedString() -> NSAttributedString{
        let string = workerList?.reduce("", combine: { (s :String, w :NODLabour?) -> String in
            s + w!.labourName! + "  "
        })
        let font = UIFont.systemFontOfSize(17)
        let attrString = NSMutableAttributedString(string: string!)
        let paragraghStype = NSMutableParagraphStyle()
        paragraghStype.paragraphSpacing = 1 * font.pointSize
        attrString.addAttribute(NSParagraphStyleAttributeName, value: paragraghStype, range: NSMakeRange(0, attrString.length))
        return attrString
    }
    
    
    override var description: String {
        get{
            return "weather:\(weather) \n  workLoad:\(workLoad) \n people :\(workerList)"
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
