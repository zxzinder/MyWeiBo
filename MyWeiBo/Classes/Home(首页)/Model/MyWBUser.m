//
//  MyWBUser.m
//  MyWeiBo
//
//  Created by MacMini on 15/11/27.
//  Copyright © 2015年 MacMini. All rights reserved.
//

#import "MyWBUser.h"

@implementation MyWBUser

-(void)setMbtype:(int)mbtype{
    
    _mbtype = mbtype;
    
    self.vip = mbtype > 2;
    
}

@end
