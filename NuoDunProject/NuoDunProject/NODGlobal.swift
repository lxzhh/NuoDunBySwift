//
//  NODGlobal.swift
//  NuoDunProject
//
//  Created by 乐星宇 on 15/6/27.
//  Copyright (c) 2015年 lxzhh. All rights reserved.
//

import UIKit

extension String{
    func toCurrency() -> String{
        return "￥\(self)"
    }
}

class NODGlobal: NSObject {
    var currentUser : LoginUser?

    
    
    func saveLoginUser(loginUser :LoginUser?){
      let archive =   NSKeyedArchiver()
    }
}
