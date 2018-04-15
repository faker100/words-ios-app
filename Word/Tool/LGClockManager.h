//
//  LGClockManager.h
//  Word
//
//  Created by caoguochi on 2018/4/7.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LGClockModel.h"

// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@class LGPushNotificationTrigger;

//管理本地通知
@interface LGClockManager : NSObject

+ (instancetype)shareManager;

//获取所有闹钟
+ (NSMutableArray<LGClockModel *> *)allClocks;


/**
 已经所有本地推送，本地缓存
 */
- (void)removeAllClock;

/**
 检查所有闹钟
 删除已推送过的闹钟
 把本地不重复的且已过期闹钟的isUse 设置为 NO
 */
- (void)checkAllClock;

/**
 添加闹钟
 推送、本地model缓存都会添加
 @param clock 闹钟
 @param completion 回调 isSuccess是否成功
 */
- (void)addClock:(LGClockModel *)clock completion:(void(^)(BOOL isSuccess))completion;


/**
 删除闹钟
 推送、本地model缓存都会删除
 @param clock 闹钟
 */
- (void)removeClock:(LGClockModel *)clock;


/**
 更新闹钟时间
 推送、本地model缓存都会更新
 @param clock 闹钟
 */
- (void)updateClockDate:(LGClockModel *)clock completion:(void(^)(BOOL isSuccess))completion;


/**
 更新闹钟是否可用
推送、本地model缓存都会更新
 @param clock 闹钟
 */
- (void)updateClockUse:(LGClockModel *)clock completion:(void(^)(BOOL isSuccess))completion;

@end
