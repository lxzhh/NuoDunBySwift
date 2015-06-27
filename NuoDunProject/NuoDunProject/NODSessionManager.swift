//
//  NODSessionManager.swift
//  
//
//  Created by lxzhh on 15/6/20.
//
//

import UIKit

let urlString :String  = "http://115.231.54.166:9090/jobrecordapp.asmx"

class NODSessionManager: AFHTTPSessionManager {
    class var sharedInstance: NODSessionManager {
        struct Static {
//            let configure :NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
//            configure.response
            static let instance: NODSessionManager = NODSessionManager(baseURL: NSURL(string:urlString))
        }
        Static.instance.responseSerializer = AFHTTPResponseSerializer()

        return Static.instance
    }
   
}
