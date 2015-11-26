//
//  MyWBAccountTool.h
//  MyWeiBo
//
//  Created by MacMini on 15/11/26.
//  Copyright © 2015年 MacMini. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MyWBAccount;
@interface MyWBAccountTool : NSObject

+(void)saveAccount:(MyWBAccount *)account;

+(MyWBAccount *)account;

@end
