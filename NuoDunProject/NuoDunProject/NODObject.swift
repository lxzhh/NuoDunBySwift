//
//  NODObject.swift
//  NuoDunProject
//
//  Created by 乐星宇 on 15/7/13.
//  Copyright (c) 2015年 lxzhh. All rights reserved.
//

import UIKit

class NODObject: NSObject,Mappable, Printable {
    override init(){}
    required init?(_ map: Map) {
        super.init()
        mapping(map)
    }
    
    // Mappable
    func mapping(map: Map) {
    }
    
    class func saveKey() -> String?{
        let string = toString(self.dynamicType)
//        let key = string.componentsSeparatedByString(".").last!
        return "\(string)"
    }
    
    class func loadJsonRootKey() -> String?{
        return ""
    }
    
    class func saveToLocal(string :String){
        NSUserDefaults.standardUserDefaults().setObject(string, forKey: self.saveKey()!)
    }
    
    class func loadSavedJson<T : Mappable>(type : T.Type) -> [T]?{
        let resultString =  NSUserDefaults.standardUserDefaults().stringForKey(self.saveKey()!)
        let jdata: NSData = resultString!.dataUsingEncoding(NSUTF8StringEncoding)!
        let error : NSErrorPointer;
        let json  = JSON(data: jdata)
        let array = json[self.loadJsonRootKey()!].arrayObject
        let groups = Mapper<T>().mapArray(array)
        println(array)
        return groups
    }

}
