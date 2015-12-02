//
//  MyWBStatusSingleImageView.m
//  MyWeiBo
//
//  Created by alexzinder on 15/12/2.
//  Copyright © 2015年 MacMini. All rights reserved.
//

#import "MyWBStatusSingleImageView.h"
#import "UIImageView+WebCache.h"
#import "MyWBPhoto.h"

@interface MyWBStatusSingleImageView()

@property (nonatomic,weak)UIImageView *gifView;

@end


@implementation MyWBStatusSingleImageView

-(UIImageView *)gifView{
    
    if (_gifView == nil) {
        UIImage *image = [UIImage imageNamed:@"timeline_image_gif"];
        UIImageView *gifView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:gifView];
        
        self.gifView = gifView;
    }
    
    return _gifView;
    
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        self.contentMode = UIViewContentModeScaleAspectFill;
        
        self.clipsToBounds = YES;
    }
    
    return self;
    
}

-(void)setPhoto:(MyWBPhoto *)photo{
    
    _photo =photo;
    
    [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    self.gifView.hidden = ![photo.thumbnail_pic.lowercaseString hasSuffix:@"gif"];
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.gifView.x = self.width - self.gifView.width;
    self.gifView.y = self.height - self.gifView.height;
    
}

@end









