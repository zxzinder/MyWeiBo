//
//  NSDate+Extension.m
//  MyWeiBo
//
//  Created by MacMini on 15/12/2.
//  Copyright © 2015年 MacMini. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

/**
 *  判断是否为今年
 *
 *  @return 返回bool
 */
-(BOOL)isThisYear{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *dateCmps = [calendar components:NSCalendarUnitYear fromDate:self];
    
    NSDateComponents *nowCmps = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    
    return dateCmps.year = nowCmps.year;
    
}

-(BOOL)isYesterday{
    
    NSDate *now = [NSDate date];
    // date ==  2014-04-30 10:05:28 --> 2014-04-30 00:00:00
    // now == 2014-05-01 09:22:10 --> 2014-05-01 00:00:00

    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
        // 2014-04-30
    NSString *dateStr = [fmt stringFromDate:self];
    // 2014-10-18

    NSString *nowStr = [fmt stringFromDate:now];
    // 2014-10-30 00:00:00
    NSDate *date = [fmt dateFromString:dateStr];
        // 2014-10-18 00:00:00
    now = [fmt dateFromString:nowStr];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    
    NSDateComponents *cmps = [calendar components:unit fromDate:date toDate:now options:0];
    
    return cmps.year == 0 && cmps.month == 0 && cmps.day == 1;
    
}

-(BOOL)isToday{
    
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyy-MM-dd";
    
    NSString *dateStr = [fmt stringFromDate:self];
    NSString *nowStr = [fmt stringFromDate:now];
    
    return [dateStr isEqualToString:nowStr];
    
    
}

@end
