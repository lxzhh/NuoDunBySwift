//
//  NODWorker.swift
//  NuoDunProject
//
//  Created by redhat' iMac on 15/7/4.
//  Copyright (c) 2015年 lxzhh. All rights reserved.
//

import UIKit

class NODWorker: NSObject,Mappable, Printable  {
    var workCate : String?
    var entryDate : String?
    var basicSalary : Float?
    var workerName : String?
    var bankAccount : String?
    var originPlace : String?
    var telephone : String?
    var bankAccountName : String?
    var bankName : String?
    var dailySalary : Float?
    var identityNumber : String?
    var gender : String?
    var stateCode : String?
    var status : Bool?
    var address : String?
    
    override init(){}
    required init?(_ map: Map) {
        super.init()
        mapping(map)
    }
    
    // Mappable
    func mapping(map: Map) {
        workCate <- map["BZMC"]
        entryDate <- map["RZRQ"]
        basicSalary <- map["JBGZ"]
        dailySalary <- map["RGZ"]
        workerName <- map["XM"]
        bankAccount <- map["GZKH"]
        telephone <- map["LXDH"]
        originPlace <- map["HJD"]
        bankAccountName <- map["KHM"]
        bankName <- map["KHH"]
        identityNumber <- map["SFZH"]
        gender <- map["XB"]
        
        stateCode <- map["GRZTMC"]
        address <- map["JZD"]

    }
    override var description: String {
        get{
            return "workerName:\(workerName) \n  bankName:\(bankName)"
        }
    }
}
