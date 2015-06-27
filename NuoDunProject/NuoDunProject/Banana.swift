//
//  Banana.swift
//  NuoDunProject
//
//  Created by redhat' iMac on 15/6/27.
//  Copyright (c) 2015年 lxzhh. All rights reserved.
//

import UIKit

class Banana: NSObject {
   private var isPeeled = false
    
    public func peel(){
        isPeeled = true
    }
    
    
    public var isEdible: Bool{
        return isPeeled
    }
}
