//
//  SlideMenuController+NODTrasition.swift
//  NuoDunProject
//
//  Created by redhat' iMac on 15/6/28.
//  Copyright (c) 2015年 lxzhh. All rights reserved.
//

import Foundation
enum NODSlideMainViewType : String{
    case NODSlideMainViewTypeHome = "NODConstructionController"
    case NODSlideMainViewTypeFinacial = "NODFiancialController"
    case NODSlideMainViewTypeLabour = "NODLabourController"
    case NODSlideMainViewTypeSetting = "NODSettingVC"
    
}

extension SlideMenuController {
    func slideMainViewWithType(type :NODSlideMainViewType){
        let vc : NODBaseMainViewController = UIStoryboard(name: "NODStoryboard", bundle: nil).instantiateViewControllerWithIdentifier(type.rawValue) as! NODBaseMainViewController
        let navc = UINavigationController(rootViewController: vc)
        self.slideMenuController()?.changeMainViewController(navc, close: true)
    }
}