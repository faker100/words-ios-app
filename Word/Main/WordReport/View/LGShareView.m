//
//  LGShareView.m
//  Word
//
//  Created by caoguochi on 2018/4/23.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGShareView.h"

@implementation LGShareView

- (IBAction)cancelAction:(id)sender {
    [self removeFromSuperview];
}

- (IBAction)tapAction:(id)sender {
    [self removeFromSuperview];
}

/**
 选择平台
 
 @param sender tag - 100，微信
 tag - 101, 朋友圈
 tag - 102, QQ
 tag - 103, 空间
 */
- (IBAction)platformAction:(UIButton *)sender {
    
    SSDKPlatformType platformType = 0;
    switch (sender.tag) {
        case 100:
            platformType = SSDKPlatformSubTypeWechatSession;
            break;
        case 101:
            platformType = SSDKPlatformSubTypeWechatTimeline;
            break;
        case 102:
            platformType = SSDKPlatformSubTypeQQFriend;
            break;
        case 103:
            platformType = SSDKPlatformSubTypeQZone;
            break;
    }
    self.selectedPlatform(platformType);
}



/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
