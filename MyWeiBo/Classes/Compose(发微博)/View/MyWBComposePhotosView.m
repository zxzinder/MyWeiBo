//
//  MyWBComposePhotosView.m
//  MyWeiBo
//
//  Created by MacMini on 15/12/4.
//  Copyright © 2015年 MacMini. All rights reserved.
//

#import "MyWBComposePhotosView.h"

@implementation MyWBComposePhotosView

-(instancetype)initWithFrame:(CGRect)frame{
    
    
    self = [super initWithFrame:frame];
    
    if (self) {
        _photos = [NSMutableArray array];
        
    }
    return self;
}

-(void)addPhoto:(UIImage *)image{
    
    UIImageView *photoView = [[UIImageView alloc ] init];
    photoView.image = image;
    [self addSubview:photoView];
    
    [self.photos addObject:image];
    
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    NSUInteger count = self.subviews.count;
    int maxCol = 4;
    CGFloat imageWH = 70;
    CGFloat imageMargin = 10;
    
    for (int i = 0; i<count; i++) {
        UIImageView *photoView = [[UIImageView alloc ] init];
        
        int col = i % maxCol;
        photoView.x = col *(imageWH + imageMargin);
        
        int row = i / maxCol;
        
        photoView.y = row * (imageWH + imageMargin);
        
        photoView.width = imageWH;
        photoView.height = imageWH;
    }
}

@end
