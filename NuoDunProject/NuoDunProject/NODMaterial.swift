//
//  NODMaterial.swift
//  NuoDunProject
//
//  Created by lxzhh on 15/7/14.
//  Copyright (c) 2015年 lxzhh. All rights reserved.
//

import UIKit

class NODMaterial: NODObject {
    var materialName : String?
    var materialID : String?
    
    required init?(_ map: Map) {
        super.init()
        mapping(map)
    }
    
    // Mappable
    override func mapping(map: Map) {
        materialName <- map["CLMC"]
        materialID <- map["CLBM"]
        
    }
    override var description: String {
        get{
            return "materialName:\(materialName) \n  materialID:\(materialID)"
        }
    }
    
    override class func loadJsonRootKey() -> String?{
        return "CL"
    }
}
