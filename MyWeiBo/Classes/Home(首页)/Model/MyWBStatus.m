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

-(NSString *)created_at{
    
    // _created_at == Thu Oct 16 17:06:25 +0800 2014 现在得到的string
    // dateFormat == EEE MMM dd HH:mm:ss Z yyyy
    // NSString --> NSDate
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    // 设置日期格式（声明字符串里面每个数字和单词的含义）
    
    // E:星期几
    // M:月份
    // d:几号(这个月的第几天)
    // H:24小时制的小时
    // m:分钟
    // s:秒
    // y:年
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    //微博创建的日期
    NSDate *createDate = [fmt dateFromString:_created_at];
    //当前时间
    NSDate *now = [NSDate date];
    //日历对象
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // NSCalendarUnit枚举代表想获得哪些差值
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour |NSCalendarUnitMinute |NSCalendarUnitSecond;
    
    //计算两个日期之间的差值
    NSDateComponents *cmps = [calendar components:unit fromDate:createDate toDate:now options:0];
    
    //MyLog(@"createDate-%@ now-%@ cmps-%@", createDate, now, cmps);
    
    if ([createDate isThisYear]) {//今年
        if ([createDate isYesterday]) {//昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:createDate];
        }else if([createDate isToday]){
            
            if (cmps.hour >= 1) {
                return [NSString stringWithFormat:@"%ld小时前",(long)cmps.hour];
            }else if(cmps.minute >= 1){
                
                return [NSString stringWithFormat:@"%ld分钟前",(long)cmps.minute];
                
            }else{
                
                return @"刚刚";
            }
            
        }else{
            
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:createDate];
            
        }
    }else{//不是今年，往年的时间显示
        
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return  [fmt stringFromDate:createDate];
        
    }
    
    
}
// source == <a href="http://app.weibo.com/t/feed/2llosp" rel="nofollow">OPPO_N1mini</a>
-(void)setSource:(NSString *)source{
    //MyLog(@"source --- %@",source);
    if (source.length) {
        NSRange range = NSMakeRange(0, 0);
        range.location = [source rangeOfString:@">"].location + 1;
        range.length = [source rangeOfString:@"</" options:NSBackwardsSearch].location - range.location;
        NSString *newStr = [source substringWithRange:range];
        _source = [NSString stringWithFormat:@"来自%@",newStr];
    }else{
        
        _source =[NSString stringWithFormat:@"来自微博 weibo.com"];;
    }
   
    
}



@end









