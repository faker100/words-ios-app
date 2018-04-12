//
//  AppDelegate.h
//  Word
//
//  Created by Charles Cao on 2018/1/15.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <VodSDK/VodSDK.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) VodPlayer *vodplayer;

/**
 *  是否强制横屏
 */
@property (nonatomic, assign) BOOL isForceLandscape;
/**
 *  是否强制竖屏
 */
@property (nonatomic, assign) BOOL isForcePortrait;

@end

