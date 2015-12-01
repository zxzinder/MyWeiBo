//
//  MyWBStatus.m
//  MyWeiBo
//
//  Created by MacMini on 15/11/27.
//  Copyright © 2015年 MacMini. All rights reserved.
//

#import "MyWBStatus.h"
#import "MyWBPhoto.h"
#import "YYModel.h"




@implementation MyWBStatus


+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"pic_urls" : [MyWBPhoto class]};
}


@end
