//
//  MyWBStatusCell.m
//  MyWeiBo
//
//  Created by MacMini on 15/12/1.
//  Copyright © 2015年 MacMini. All rights reserved.
//

#import "MyWBStatusCell.h"
#import "MyWBStatusFrame.h"
#import "MyWBStatus.h"
#import "MyWBUser.h"
#import "UIImageView+WebCache.h"
#import "MyWBPhoto.h"


@interface MyWBStatusCell()

/* 原创微博 */
/** 原创微博整体 */
@property (nonatomic, weak) UIView *originalView;
/** 头像 */
@property (nonatomic, weak) UIImageView *iconView;
/** 会员图标 */
@property (nonatomic, weak) UIImageView *vipView;
/** 配图 */
@property (nonatomic, weak) UIImageView *photoView;
/** 昵称 */
@property (nonatomic, weak) UILabel *nameLabel;
/** 时间 */
@property (nonatomic, weak) UILabel *timeLabel;
/** 来源 */
@property (nonatomic, weak) UILabel *sourceLabel;
/** 正文 */
@property (nonatomic, weak) UILabel *contentLabel;

/* 转发微博 */
/** 转发微博整体 */
@property (nonatomic,weak)UIView *retweetView;

@property (nonatomic,weak)UILabel *retweetContentLabel;

@property (nonatomic,weak)UIImageView *retweetPhotoView;

@end

@implementation MyWBStatusCell
+(instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *ID =@"status";
    
    MyWBStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[MyWBStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self setupOriginal];
        
        [self setupRetweet];
        
    }
    return self;
}

-(void)setupRetweet{
    
    /** 转发微博整体 */
    UIView *retweetView = [[UIView alloc] init];
    retweetView.backgroundColor = MyWBColor(240, 240, 240);
    [self.contentView addSubview:retweetView];
    self.retweetView = retweetView;
    
    /** 转发微博正文 + 昵称 */
    UILabel *retweetContentLabel = [[UILabel alloc] init];
    retweetContentLabel.numberOfLines = 0;
    retweetContentLabel.font = StatusCellRetweetContentFont;
    [retweetView addSubview:retweetContentLabel];
    self.retweetContentLabel = retweetContentLabel;
    
    /** 转发微博配图 */
    UIImageView *retweetPhotoView = [[UIImageView alloc] init];
    [retweetView addSubview:retweetPhotoView];
    self.retweetPhotoView = retweetPhotoView;
    
}

-(void)setupOriginal{
    UIView *originalView = [[UIView alloc] init];
    [self.contentView addSubview:originalView];
    self.originalView = originalView;
    
    /** 头像 */
    UIImageView *iconView = [[UIImageView alloc] init];
    [originalView addSubview:iconView];
    self.iconView = iconView;
    
    /** 会员图标 */
    UIImageView *vipView = [[UIImageView alloc] init];
    vipView.contentMode = UIViewContentModeCenter;
    [originalView addSubview:vipView];
    self.vipView = vipView;
    
    /** 配图 */
    UIImageView *photoView = [[UIImageView alloc] init];
    [originalView addSubview:photoView];
    self.photoView = photoView;
    
    /** 昵称 */
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = StatusCellNameFont;
    [originalView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    /** 时间 */
    UILabel *timeLabel = [[UILabel alloc] init];
    [originalView addSubview:timeLabel];
    timeLabel.font = StatusCellTimeFont;
    self.timeLabel = timeLabel;
    
    /** 来源 */
    UILabel *sourceLabel = [[UILabel alloc] init];
    sourceLabel.font = StatusCellSourceFont;
    [originalView addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;
    
    /** 正文 */
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.font = StatusCellContentFont;
    contentLabel.numberOfLines = 0;
    [originalView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
    
}

-(void)setStatusFrame:(MyWBStatusFrame *)statusFrame{
    
    _statusFrame = statusFrame;
    MyWBStatus *status = statusFrame.status;
    MyWBUser *user = status.user;
    
    self.originalView.frame = statusFrame.originalViewF;
    
    self.iconView.frame = statusFrame.iconViewF;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.avatar_large] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    /** 会员图标 */
    
    if (user.isVip) {
        self.vipView.hidden = NO;
        
        self.vipView.frame = statusFrame.vipViewF;
        
        NSString *vipName = [NSString stringWithFormat:@"common_icon_membership_level%d",user.mbrank];
        
        self.vipView.image = [UIImage imageNamed:vipName];
        
        self.nameLabel.textColor = [UIColor orangeColor];
    }else{
        
        self.nameLabel.textColor = [UIColor blackColor];
        self.vipView.hidden = YES;
        
    }
    
    /** 配图 */
    
    if (status.pic_urls.count) {
        self.photoView.frame = statusFrame.photoViewF;
        MyWBPhoto *photo = [status.pic_urls firstObject];
        [self.photoView sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
        
        self.photoView.hidden = NO;
    }else{
        
        self.photoView.hidden = YES;
        
    }
    
    /** 昵称 */
    self.nameLabel.text = user.name;
    self.nameLabel.frame = statusFrame.nameLabelF;
    
    /** 时间 */
    self.timeLabel.text = status.created_at;
    self.timeLabel.frame = statusFrame.timeLabelF;
    
    /** 来源 */
    self.sourceLabel.frame = statusFrame.sourceLabelF;
    self.sourceLabel.text = status.source;
    /** 正文 */
    self.contentLabel.text = status.text;
    self.contentLabel.frame = statusFrame.contentLabelF;
    
    
    /** 被转发的微博 */
    
    if (status.retweeted_status) {
        MyWBStatus *retweeted_status = status.retweeted_status;
        
        MyWBUser *retweeted_status_user = retweeted_status.user;
        
        self.retweetView.hidden = NO;
        
        self.retweetView.frame = statusFrame.retweetViewF;
        
        NSString *retweetContent = [NSString stringWithFormat:@"@%@ : %@",retweeted_status_user.name,retweeted_status.text];
        
        self.retweetContentLabel.text = retweetContent;
        self.retweetContentLabel.frame = statusFrame.retweetContentLabelF;
        
        if (retweeted_status.pic_urls.count >0 ) {
        
            MyWBPhoto *retweetedPhoto = [retweeted_status.pic_urls firstObject];
           // MyLog(@"图片数：%lu  图片urls%@  名字%@  photo%@",(unsigned long)retweeted_status.pic_urls.count,retweeted_status.pic_urls,user.name,retweetedPhoto.thumbnail_pic);
            [self.retweetPhotoView sd_setImageWithURL:[NSURL URLWithString:retweetedPhoto.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
            
            self.retweetPhotoView.frame = statusFrame.retweetPhotoViewF;

            self.retweetPhotoView.hidden = NO;
        }else{
            
            self.retweetPhotoView.hidden = YES;
            
        }
        
        
    }else{
        
        self.retweetView.hidden = YES;
        
    }
    
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end







