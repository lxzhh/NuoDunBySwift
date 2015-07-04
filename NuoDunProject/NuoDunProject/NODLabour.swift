//
//  NODLabour.swift
//  NuoDunProject
//
//  Created by redhat' iMac on 15/7/4.
//  Copyright (c) 2015年 lxzhh. All rights reserved.
//

import UIKit
class NODLabour: NSObject, Mappable, Printable{
    var labourId : String?
    var labourName : String?
    override init(){}
    required init?(_ map: Map) {
        super.init()
        mapping(map)
    }
    
    // Mappable
    func mapping(map: Map) {
        labourId <- map["SFZH"]
        labourName <- map["XM"]
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
