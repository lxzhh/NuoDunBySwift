//
//  CALayer+XibConfiguration.m
//  CoolOffice
//
//  Created by redhat' iMac on 14-9-25.
//  Copyright (c) 2014年 lxzhh. All rights reserved.
//

#import "CALayer+XibConfiguration.h"

@implementation CALayer(XibConfiguration)

-(void)setBorderUIColor:(UIColor*)color
{
    self.borderColor = color.CGColor;
}

-(UIColor*)borderUIColor
{
    return [UIColor colorWithCGColor:self.borderColor];
}

@end