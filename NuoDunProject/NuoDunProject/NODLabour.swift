//
//  NODLabour.swift
//  NuoDunProject
//
//  Created by redhat' iMac on 15/7/4.
//  Copyright (c) 2015年 lxzhh. All rights reserved.
//

import UIKit
class NODLabour: NODObject{
    var labourId : String?
    var labourName : String?
    var workerCode : String?
    required init?(_ map: Map) {
        super.init()
        mapping(map)
    }
    
    // Mappable
    override func mapping(map: Map) {
        labourId <- map["SFZH"]
        labourName <- map["XM"]
        workerCode <- map["GRBM"]
    }
    override class func saveKey() -> String?{
        return "NODLabour"
    }
    override class func loadJsonRootKey() -> String?{
        return "GR"
    }
    
    override var description: String {
        get{
            return "labourId:\(labourId) \n  labourName:\(labourName)"
        }
    }
}


class NODLabourCategory: NSObject, Mappable, Printable {
    var categoryName :String?
    var labourList :Array<NODLabour>?
    
    override init(){}
    required init?(_ map: Map) {
        super.init()
        mapping(map)
    }
    
    // Mappable
    func mapping(map: Map) {
        categoryName <- map["BZMC"]
        labourList <- map["BZ"]
    }
    
    override var description: String {
        get{
            return "categoryName:\(categoryName) \n  labourList:\(labourList)"
        }
    }
}
