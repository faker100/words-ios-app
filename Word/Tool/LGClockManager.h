//
//  LGClockManager.h
//  Word
//
//  Created by caoguochi on 2018/4/7.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LGClockModel.h"
// 引入JPush功能所需头文件
#import "JPUSHService.h"
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

//存闹钟 数组
+ (void)saveClocks:(NSMutableArray<LGClockModel *> *)clocks;

- (void)addClock:(LGClockModel *)clock completion:(void(^)(BOOL isSuccess))completion;

- (void)removeClock:(LGClockModel *)clock;

- (void)updateClock:(LGClockModel *)clock;



@end

@interface LGPushNotificationTrigger : JPushNotificationTrigger



@end
