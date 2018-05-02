//
//  LGShareView.h
//  Word
//
//  Created by caoguochi on 2018/4/23.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LGShareView : UIView

@property (nonatomic, copy) void(^selectedPlatform)(SSDKPlatformType type);

@property (nonatomic, strong) NSMutableDictionary *shareParams;



@end
