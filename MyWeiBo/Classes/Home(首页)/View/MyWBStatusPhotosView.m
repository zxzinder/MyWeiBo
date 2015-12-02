//
//  MyWBStatusPhotosView.m
//  MyWeiBo
//
//  Created by alexzinder on 15/12/2.
//  Copyright © 2015年 MacMini. All rights reserved.
//

#import "MyWBStatusPhotosView.h"
#import "MyWBStatusSingleImageView.h"
#define StatusPhotoWH 70
#define StatusPhotoMargin 5
#define StatusPhotoMaxCol(count) ((count==4)?2:3)

@implementation MyWBStatusPhotosView

+(CGSize)sizeWithCount:(NSInteger)count{
    
    int maxCols = StatusPhotoMaxCol(count);
    
    int cols = (count >= maxCols) ? maxCols : count;
    
    CGFloat photosW = cols * StatusPhotoWH + (cols - 1) * StatusPhotoMargin;
    
    int rows = (count + maxCols - 1) / maxCols;
    
    CGFloat photoH = rows * StatusPhotoWH + (rows - 1) * StatusPhotoMargin;
    
    return CGSizeMake(photosW, photoH);
    
}


-(void)setPhotos:(NSArray *)photos{
    
    _photos = photos;
    
    NSInteger photosCount = photos.count;
    
    while (self.subviews.count < photosCount) {
        MyWBStatusSingleImageView *photoView = [[MyWBStatusSingleImageView alloc] init];
        [self addSubview:photoView];
    }
    
    for (int i = 0 ; i < self.subviews.count; i++) {
        MyWBStatusSingleImageView *photoView = self.subviews[i];
        
        if (i < photosCount) {
            photoView.photo = photos[i];
            photoView.hidden = NO;
        }else{
            
            photoView.hidden = YES;
        }
    }
    
}

-(void)layoutSubviews{
    
    
    [super layoutSubviews];
    
    NSInteger photosCount = self.photos.count;
    
    int maxCols = StatusPhotoMaxCol(photosCount);
    
    for (int i = 0 ; i<photosCount; i++) {
        MyWBStatusSingleImageView *photoView = self.subviews[i];
        
        int col = i % maxCols;
        photoView.x = col * (StatusPhotoMargin + StatusPhotoWH);
        
        int row = i / maxCols;
        
        photoView.y = row * (StatusPhotoWH + StatusPhotoMargin);
        
        photoView.width = StatusPhotoWH;
        
        photoView.height = StatusPhotoWH;
        
    }
    
}

@end










