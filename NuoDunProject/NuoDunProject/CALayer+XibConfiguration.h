//
//  CALayer+XibConfiguration.h
//  CoolOffice
//
//  Created by redhat' iMac on 14-9-25.
//  Copyright (c) 2014年 lxzhh. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface CALayer(XibConfiguration)

// This assigns a CGColor to borderColor.
@property(nonatomic, assign) UIColor* borderUIColor;

@end
