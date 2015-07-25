//
//  Array+NODExtention.swift
//  NuoDunProject
//
//  Created by lxzhh on 15/7/19.
//  Copyright (c) 2015年 lxzhh. All rights reserved.
//

import Foundation
extension Array {
    func foreach(functor: (T) -> ()) {
        for element in self {
            functor(element)
        }
    }
}
