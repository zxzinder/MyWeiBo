//
//  MyWBLoadMoreFooter.m
//  MyWeiBo
//
//  Created by MacMini on 15/11/30.
//  Copyright © 2015年 MacMini. All rights reserved.
//

#import "MyWBLoadMoreFooter.h"

@implementation MyWBLoadMoreFooter


+(instancetype)footer{
    
    
    return  [[[NSBundle mainBundle] loadNibNamed:@"MyWBLoadMoreFooter" owner:nil options:nil] lastObject];
    
}

@end
