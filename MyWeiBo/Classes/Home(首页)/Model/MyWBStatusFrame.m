//
//  MyWBStatusFrame.m
//  MyWeiBo
//
//  Created by MacMini on 15/12/1.
//  Copyright © 2015年 MacMini. All rights reserved.
//

#import "MyWBStatusFrame.h"
#import "MyWBUser.h"
#import "MyWBStatus.h"
// cell的边框宽度
#define StatusCellBorderW 10
#define StatusLittleBorder 4

@implementation MyWBStatusFrame

-(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxW{
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    
}

-(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font{
    
    return [self sizeWithText:text
                         font:font maxW:MAXFLOAT];
    
}

-(void)setStatus:(MyWBStatus *)status{
    
    _status = status;
    
    MyWBUser *user = status.user;
    
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    
    //头像
    
    CGFloat iconWH = 35;
    CGFloat iconX = StatusCellBorderW;
    CGFloat iconY = StatusCellBorderW;
    
    self.iconViewF = CGRectMake(iconX, iconY, iconWH, iconWH);
    
    //昵称
    
    CGFloat nameX = CGRectGetMaxX(self.iconViewF) + StatusCellBorderW;
    CGFloat nameY = iconY;
    CGSize nameSize = [self sizeWithText:user.name font:StatusCellNameFont];
    self.nameLabelF = (CGRect){{nameX,nameY},nameSize};
    
    //会员图标
    if (user.isVip) {
        CGFloat vipX = CGRectGetMaxX(self.nameLabelF ) + StatusCellBorderW;
        CGFloat vipY = nameY;
        CGFloat vipW = 14;
        CGFloat vipH = nameSize.height;
        self.vipViewF = CGRectMake(vipX, vipY, vipW, vipH);
        
    }
    
    //时间
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(self.nameLabelF) + StatusLittleBorder;
    CGSize timeSize = [self sizeWithText:status.created_at font:StatusCellTimeFont];
    self.timeLabelF = (CGRect){{timeX,timeY},timeSize};
    
    //来源
    CGFloat sourceX = CGRectGetMaxX(self.timeLabelF) + StatusCellBorderW;
    CGFloat sourceY =timeY;
    CGSize sourceSize = [self sizeWithText:status.source font:StatusCellSourceFont];
    self.sourceLabelF = (CGRect){{sourceX,sourceY},sourceSize};
    
    //正文
    CGFloat contentX = iconX;
    CGFloat contentY = MAX(CGRectGetMaxY(self.iconViewF), CGRectGetMaxY(self.timeLabelF)) + StatusCellBorderW;
    
    CGFloat maxW = cellW - 2 * contentX;
    CGSize contentSize = [self sizeWithText:status.text font:StatusCellContentFont maxW:maxW];
    self.contentLabelF = (CGRect){{contentX,contentY},contentSize};
    //配图
    CGFloat originalH = 0;
    
    if (status.pic_urls.count) {
        CGFloat photoX = contentX;
        CGFloat photoY = CGRectGetMaxY(self.contentLabelF) +StatusLittleBorder;
        CGFloat photoWH = 80;
        
        self.photoViewF = CGRectMake(photoX, photoY, photoWH, photoWH);
        
        originalH = CGRectGetMaxY(self.photoViewF) + StatusCellBorderW;
        
    }else{
        
        originalH = CGRectGetMaxY(self.contentLabelF) + StatusCellBorderW;
        
    }
    
    
    //整体
    CGFloat originalX = 0;
    CGFloat originalY = 0;
    CGFloat originalW = cellW;
    //CGFloat originalH = CGRectGetMaxY(self.contentLabelF) + StatusCellBorderW;
    
    self.originalViewF = CGRectMake(originalX, originalY, originalW, originalH);
    
   
    
    /* 被转发微博 */
    
    if (status.retweeted_status) {
        MyWBStatus *retweeted_status = status.retweeted_status;
        MyWBUser *retweeted_status_user = retweeted_status.user;
        
        CGFloat retweetContentX = StatusCellBorderW;
        CGFloat retweetContentY = StatusCellBorderW;
        
        NSString *retweetContent = [NSString stringWithFormat:@"@%@ : %@",retweeted_status_user.name,retweeted_status.text];
        
        CGSize retweetContentSize = [self sizeWithText:retweetContent font:StatusCellRetweetContentFont maxW:maxW];
        
        self.retweetContentLabelF = (CGRect){{retweetContentX,retweetContentY},retweetContentSize};
        
        
        CGFloat retweetH = 0 ;
        if (retweeted_status.pic_urls.count) {
            CGFloat retweetPhotoWH = 80;
            CGFloat retweetPhotoX = retweetContentX;
            CGFloat retweetPhotoY = CGRectGetMaxY(self.retweetContentLabelF) + StatusLittleBorder;
            
            self.retweetPhotoViewF = CGRectMake(retweetPhotoX, retweetPhotoY, retweetPhotoWH, retweetPhotoWH);
            
            retweetH = CGRectGetMaxY(self.retweetPhotoViewF) + StatusCellBorderW;
        }else{
            
            retweetH = CGRectGetMaxY(self.retweetContentLabelF) + StatusCellBorderW;
            
        }
        
         /** 被转发微博整体 */
        CGFloat retweetX = 0;
        
        CGFloat retweetY = CGRectGetMaxY(self.originalViewF);
        
        CGFloat retweetW = cellW;
        
        self.retweetViewF = CGRectMake(retweetX, retweetY, retweetW, retweetH);
        
        self.cellHeight = CGRectGetMaxY(self.retweetViewF);
        
        
        
    }else{
        
         self.cellHeight = CGRectGetMaxY(self.originalViewF);
        
    }
}

@end















