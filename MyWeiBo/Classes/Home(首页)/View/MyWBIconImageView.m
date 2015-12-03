//
//  MyWBIconImageView.m
//  MyWeiBo
//
//  Created by MacMini on 15/12/3.
//  Copyright © 2015年 MacMini. All rights reserved.
//

#import "MyWBIconImageView.h"
#import "MyWBUser.h"
#import "UIImageView+WebCache.h"

@interface MyWBIconImageView()


@property (nonatomic, weak)UIImageView *verifiedView;

@end

@implementation MyWBIconImageView

-(UIImageView *)verifiedView{
    
    if (_verifiedView == nil) {
        UIImageView *verifiedView = [[UIImageView alloc] init];
        [self addSubview:verifiedView];
        self.verifiedView = verifiedView;
    }
    return _verifiedView;
    
    
}


-(void)setUser:(MyWBUser *)user{
    
    _user = user;
    
    [self sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    //MyLog(@"%@ %d",user.name,user.verified_type);
    switch (user.verified_type) {
            
        case UserVerifiedPersonal:
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_vip"];
             break;
        case UserVerifiedOrgMedia:
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_enterprise_vip"];
             break;
        case UserVerifiedOrgWebsite:
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_enterprise_vip"];
             break;
        case UserVerifiedOrgEnterprice:
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_enterprise_vip"];
             break;
        case UserVerifiedDaren:
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_grassroot"];
             break;
        
        default:
            self.verifiedView.hidden = YES;
            break;
            
    }
    
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.verifiedView.size = self.verifiedView.image.size;
    CGFloat scale = 0.6;
    self.verifiedView.x = self.width - self.verifiedView.width * scale;
    self.verifiedView.y = self.height - self.verifiedView.height * scale;
    
}

@end
