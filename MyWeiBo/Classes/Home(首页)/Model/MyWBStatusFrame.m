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
#import "MyWBStatusPhotosView.h"


@implementation MyWBStatusFrame



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
    CGSize nameSize = [user.name sizeWithFont:StatusCellNameFont];
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
    CGSize timeSize =[status.created_at sizeWithFont:StatusCellTimeFont];
    timeSize.width += 5;
    self.timeLabelF = (CGRect){{timeX,timeY},timeSize};
    
    //来源
    CGFloat sourceX = CGRectGetMaxX(self.timeLabelF) + StatusCellBorderW;
    CGFloat sourceY =timeY;
    CGSize sourceSize = [status.source sizeWithFont:StatusCellSourceFont];
    self.sourceLabelF = (CGRect){{sourceX,sourceY},sourceSize};
    
    //正文
    CGFloat contentX = iconX;
    CGFloat contentY = MAX(CGRectGetMaxY(self.iconViewF), CGRectGetMaxY(self.timeLabelF)) + StatusCellBorderW;
    
    CGFloat maxW = cellW - 2 * contentX;
    CGSize contentSize = [status.text sizeWithFont:StatusCellContentFont maxW:maxW];
    self.contentLabelF = (CGRect){{contentX,contentY},contentSize};
    //配图
    CGFloat originalH = 0;
    
    if (status.pic_urls.count) {
        CGFloat photoX = contentX;
        CGFloat photoY = CGRectGetMaxY(self.contentLabelF) +StatusLittleBorder;
        //CGFloat photoWH = 80;
        
        CGSize photoSize = [MyWBStatusPhotosView sizeWithCount:status.pic_urls.count];
        
        self.photosViewF = (CGRect){{photoX,photoY}, photoSize};
        
        originalH = CGRectGetMaxY(self.photosViewF) + StatusCellBorderW;
        
    }else{
        
        originalH = CGRectGetMaxY(self.contentLabelF) + StatusCellBorderW;
        
    }
    
    
    //整体
    CGFloat originalX = 0;
    CGFloat originalY = StatusCellMargin;
    CGFloat originalW = cellW;
    //CGFloat originalH = CGRectGetMaxY(self.contentLabelF) + StatusCellBorderW;
    
    self.originalViewF = CGRectMake(originalX, originalY, originalW, originalH);
    
   
    CGFloat toolbarY = 0;
    /* 被转发微博 */
    
    if (status.retweeted_status) {
        MyWBStatus *retweeted_status = status.retweeted_status;
        MyWBUser *retweeted_status_user = retweeted_status.user;
        
        CGFloat retweetContentX = StatusCellBorderW;
        CGFloat retweetContentY = StatusCellBorderW;
        
        NSString *retweetContent = [NSString stringWithFormat:@"@%@ : %@",retweeted_status_user.name,retweeted_status.text];
        
        CGSize retweetContentSize = [retweetContent sizeWithFont:StatusCellRetweetContentFont maxW:maxW];
        
        self.retweetContentLabelF = (CGRect){{retweetContentX,retweetContentY},retweetContentSize};
        
        
        CGFloat retweetH = 0 ;
        if (retweeted_status.pic_urls.count) {
            //CGFloat retweetPhotoWH = 80;
            CGFloat retweetPhotoX = retweetContentX;
            CGFloat retweetPhotoY = CGRectGetMaxY(self.retweetContentLabelF) + StatusLittleBorder;
            
            CGSize retweetPhotoSize = [MyWBStatusPhotosView sizeWithCount:retweeted_status.pic_urls.count];
            
            self.retweetPhotosViewF = (CGRect){{retweetPhotoX,retweetPhotoY},retweetPhotoSize};
            
            retweetH = CGRectGetMaxY(self.retweetPhotosViewF) + StatusCellBorderW;
        }else{
            
            retweetH = CGRectGetMaxY(self.retweetContentLabelF) + StatusCellBorderW;
            
        }
        
         /** 被转发微博整体 */
        CGFloat retweetX = 0;
        
        CGFloat retweetY = CGRectGetMaxY(self.originalViewF);
        
        CGFloat retweetW = cellW;
        
        self.retweetViewF = CGRectMake(retweetX, retweetY, retweetW, retweetH);
        
        toolbarY = CGRectGetMaxY(self.retweetViewF);
        
        
        
    }else{
        
         toolbarY = CGRectGetMaxY(self.originalViewF);
        
    }
    
    
    /**
     *  工具条
     */
    
    CGFloat toolbarX = 0;
    CGFloat toolbarW = cellW;
    CGFloat toolbarH = 35;
    
    self.toolbarF = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
    
    self.cellHeight = CGRectGetMaxY(self.toolbarF);
}

@end















