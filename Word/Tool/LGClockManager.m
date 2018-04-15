//
//  LGClockManager.m
//  Word
//
//  Created by caoguochi on 2018/4/7.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGClockManager.h"
#import "NSDate+Utilities.h"

#define CLOCK_KEY          @"CLOCK_KEY"
#define iOS_8_userInfoKey  @"identifier"


typedef NS_ENUM(NSUInteger, LGNotificationRepeatType) {
    LGNotificationRepeatNone,
    LGNotificationRepeatWeek,
    LGNotificationRepeatEveryday,
};

@implementation LGClockManager

+ (instancetype)shareManager{
    static LGClockManager *mannager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mannager = [[LGClockManager alloc]init];
    });
    return mannager;
}

- (void)removeAllClock{
    
    [LGClockManager saveUserDefaultClocks:nil];
    if (@available(iOS 10.0, *)) {
        [[UNUserNotificationCenter currentNotificationCenter] removeAllPendingNotificationRequests];
        [[UNUserNotificationCenter currentNotificationCenter] removeAllDeliveredNotifications];
    } else {
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
    }
}

- (void)checkAllClock{
    
    if (@available(iOS 10.0, *)) {
        [[UNUserNotificationCenter currentNotificationCenter]removeAllDeliveredNotifications];
    }
    NSMutableArray<LGClockModel *> *allClock = [LGClockManager allClocks];
    __block NSMutableArray<LGClockModel *> *didClock = [NSMutableArray array];
    [allClock enumerateObjectsUsingBlock:^(LGClockModel * _Nonnull clockModel, NSUInteger idx, BOOL * _Nonnull stop) {
        //不重复的闹钟
        if (clockModel.week == 0) {
            //创建时间
            CGFloat createSecs = [clockModel.identifiers.firstObject componentsSeparatedByString:@"_"].firstObject.doubleValue;
            NSDate *createDate = [[[NSDate alloc]initWithTimeIntervalSince1970:createSecs]convertToSystemTimeZoneDate];
            
            NSDateComponents *dateComponents = [NSDateComponents new];
            dateComponents.hour = clockModel.hour;
            dateComponents.minute = clockModel.minute;
            //闹钟执行时间
            NSDate *date = [[NSDate currentCalendar]nextDateAfterDate:createDate matchingComponents:dateComponents options:NSCalendarMatchNextTime];
            //执行时间是否在过去
            if ([date isInPast]) {
                [didClock addObject:clockModel];
            }
        }
    }];
    
    [didClock enumerateObjectsUsingBlock:^(LGClockModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.isUse = NO;
    }];
    [LGClockManager saveUserDefaultClocks:allClock];
}

- (void)removeClock:(LGClockModel *)clock{
    
    if (@available(iOS 10.0, *)) {
        [self removeNotification_iOS10:clock];
    }else{
        [self removeNotification_iOS8:clock];
    }
    [LGClockManager removeUserDefaultClock:clock];
}

- (void)updateClockUse:(LGClockModel *)clock completion:(void(^)(BOOL isSuccess))completion{
    
    if (clock.isUse) {
        //先删除本地缓存
        [LGClockManager removeUserDefaultClock:clock];
        //添加闹钟，添加本地缓存
        [self addClock:clock completion:completion];
    }else{
        //删除本地缓存和闹钟
        [self removeClock:clock];
        //添加闹钟，添加本地缓存
        [LGClockManager addUserDefaultClock:clock];
        completion(YES);
    }
}

- (void)updateClockDate:(LGClockModel *)clock completion:(void(^)(BOOL isSuccess))completion{
    
    //先删除之前的闹钟
    [self removeClock:clock];
    //重新生成identifiers
    clock.identifiers = nil;
    //再添加新闹钟
    [self addClock:clock completion:completion];
}

- (void)addClock:(LGClockModel *)clock completion:(void (^)(BOOL isSuccess))completion{
    
    //如果不可用，只添加本地缓存
    if (clock.isUse == NO) {
        [LGClockManager addUserDefaultClock:clock];
        completion(YES);
        return;
    }
    if (@available(iOS 10.0, *)) {
        __block NSDateComponents *dateComponents = [[NSDateComponents alloc]init];
        dateComponents.hour = clock.hour;
        dateComponents.minute = clock.minute;
        if (clock.week.count == 0) {
            //下一个匹配时间
            NSDate *date = [[NSDate currentCalendar]nextDateAfterDate:[NSDate currentDate] matchingComponents:dateComponents options:NSCalendarMatchNextTime];
            [self addNotification_iOS10:clock.identifiers.firstObject dateComponents:[date components] repeate:LGNotificationRepeatNone completion:^(BOOL isSuccess) {
                if (isSuccess) {
                    [LGClockManager addUserDefaultClock:clock];
                    completion(YES);
                }else{
                    completion(NO);
                }
            }];
        }else if(clock.week.count == 7){
            [self addNotification_iOS10:clock.identifiers.firstObject dateComponents:dateComponents repeate:LGNotificationRepeatEveryday completion:^(BOOL isSuccess) {
                if (isSuccess) {
                    [LGClockManager addUserDefaultClock:clock];
                    completion(YES);
                }else{
                    completion(NO);
                }
            }];
            
        }else{
            __block NSInteger successCount = 0;
            NSInteger weekCount = clock.week.count;
            [clock.week enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                //设置week，重复周数
                NSInteger week = obj.integerValue + 1 == 8 ? 1 : obj.integerValue + 1;
                dateComponents.weekday = week;
                [self addNotification_iOS10:clock.identifiers[idx] dateComponents:dateComponents repeate:LGNotificationRepeatWeek completion:^(BOOL isSuccess) {
                    if (isSuccess) {
                        successCount ++;
                    }
                    //添加通知是异步请求,写在block里面
                    //添加最后一个通知后，判断已成功添加次数
                    if (idx == weekCount - 1) {
                        if (successCount == weekCount) {
                            
                            [LGClockManager addUserDefaultClock:clock];
                            completion(YES);
                        }else{
                            completion(NO);
                            [[UNUserNotificationCenter currentNotificationCenter] removePendingNotificationRequestsWithIdentifiers:clock.identifiers];
                        }
                    }
                }];
            }];
        }
        //iOS 10之前
    }else{
        [[LGClockManager allClocks]addObject:clock];
        NSDateComponents *dateComponents = [[NSDateComponents alloc]init];
        dateComponents.hour = clock.hour;
        dateComponents.minute = clock.minute;
        __block NSDate *date = [[NSCalendar currentCalendar]nextDateAfterDate:[NSDate date] matchingComponents:dateComponents options:NSCalendarMatchNextTime];
        if (clock.week.count == 0) {
            [self addNotification_iOS8:clock.identifiers.firstObject date:date repeate:0 completion:^(BOOL isSuccess) {
                completion(YES);
            }];
        }else if (clock.week.count == 7){
            [self addNotification_iOS8:clock.identifiers.firstObject date:date repeate:NSCalendarUnitDay completion:^(BOOL isSuccess) {
                completion(YES);
            }];
        }else{
            [clock.week enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                //设置week，重复周数
                NSInteger week = obj.integerValue + 1 == 8 ? 1 : obj.integerValue + 1;
                dateComponents.weekday = week;
                date = [[NSCalendar currentCalendar]nextDateAfterDate:[NSDate date] matchingComponents:dateComponents options:NSCalendarMatchNextTime];
                [self addNotification_iOS8:clock.identifiers[idx] date:date repeate:NSCalendarUnitWeekday completion:^(BOOL isSuccess) {
                }];
            }];
            completion(YES);
        }
        [LGClockManager addUserDefaultClock:clock];
        
    }
}

/**
 iOS 8 移除通知
 
 */
- (void)removeNotification_iOS8:(LGClockModel *)clock{
    __block NSMutableArray <UILocalNotification *> *cancelNotification =  [NSMutableArray array];
    
    NSArray * notificationArrray = [UIApplication sharedApplication].scheduledLocalNotifications;
    [notificationArrray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UILocalNotification *notification = obj;
        NSString *identifier =  notification.userInfo[iOS_8_userInfoKey];
        [clock.identifiers enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isEqualToString:identifier]) {
                [cancelNotification addObject:notification];
                *stop = YES;
            }
        }];
        //需要取消的通知和 clock.identifiers 数量一样时，停止循环
        if (cancelNotification.count == clock.identifiers.count) {
            *stop = YES;
        }
    }];
    
    [cancelNotification enumerateObjectsUsingBlock:^(UILocalNotification * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [[UIApplication sharedApplication]cancelLocalNotification:obj];
    }];
}


/**
 iOS 10 移除通知
 
 */
- (void)removeNotification_iOS10:(LGClockModel *)clock{
    // 移除未展示过的通知
    if (@available(iOS 10.0, *)) {
        [[UNUserNotificationCenter currentNotificationCenter] getPendingNotificationRequestsWithCompletionHandler:^(NSArray<UNNotificationRequest *> * _Nonnull requests) {
            NSLog(@"%@",requests);
        }];
        
        [[UNUserNotificationCenter currentNotificationCenter] removePendingNotificationRequestsWithIdentifiers:clock.identifiers];
        [[UNUserNotificationCenter currentNotificationCenter] getPendingNotificationRequestsWithCompletionHandler:^(NSArray<UNNotificationRequest *> * _Nonnull requests) {
            NSLog(@"%@",requests);
        }];
    }
}

/**
 iOS 8 添加本地通知
 
 @param identifier 本地通知identifier
 @param date 日期
 @param repeate 重复规则
 @param completion 成功回调
 */
- (void)addNotification_iOS8:(NSString *)identifier date:(NSDate *)date repeate:(NSCalendarUnit)repeate completion:(void (^)(BOOL isSuccess))completion{
    
    
    UILocalNotification *localNotification = [[UILocalNotification alloc]init];
    
    //触发通知时间
    localNotification.fireDate = date;
    localNotification.repeatInterval = repeate;
    localNotification.userInfo = @{
                                   iOS_8_userInfoKey : identifier
                                   };
    if (@available(iOS 8.2, *)) {
        localNotification.alertTitle = @"标题";
    }
    localNotification.alertBody = @"内容";
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    
    //设置本地通知类型
    UIUserNotificationSettings *local = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
    
    //对通知进行注册
    [[UIApplication sharedApplication] registerUserNotificationSettings:local];
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    completion(YES);
    
}

/**
 iOS 10 添加本地通知
 
 @param identifier 本地通知identifier
 @param dateComponents 时间组件
 @param repeate 重复方式
 @param completion 成功回调
 */
- (void)addNotification_iOS10:(NSString *)identifier dateComponents:(NSDateComponents *)dateComponents  repeate:(LGNotificationRepeatType)repeate completion:(void (^)(BOOL isSuccess))completion{
    if (@available(iOS 10.0, *)) {
        
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        content.title = @"app标题";
        content.subtitle = @"副标题";
        content.body = @"这都是内容";
        content.sound = [UNNotificationSound defaultSound];
        UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:dateComponents repeats:repeate != LGNotificationRepeatNone];
        // 3、创建通知请求
        UNNotificationRequest *notificationRequest = [UNNotificationRequest requestWithIdentifier:identifier content:content trigger:trigger];
        // 4、将请求加入通知中心
        [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:notificationRequest withCompletionHandler:^(NSError * _Nullable error) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"添加闹钟成功：%@",error);
                completion(error == nil);
            });
        }];
    }
}

#pragma mark - 本地 LGClockModel操作


+ (NSMutableArray<LGClockModel *> *)allClocks{
    
    id arr = [[NSUserDefaults standardUserDefaults] objectForKey:CLOCK_KEY];
    return arr ? [LGClockModel mj_objectArrayWithKeyValuesArray:arr] : [NSMutableArray array];
}


/**
 本地缓存添加一个新闹钟
 
 */
+ (void)addUserDefaultClock:(LGClockModel *)clock{
    NSMutableArray *tempAllClocks = [LGClockManager allClocks];
    [tempAllClocks addObject:clock];
    [LGClockManager saveUserDefaultClocks:tempAllClocks];
}


/**
 移除本地缓存
 
 */
+ (void)removeUserDefaultClock:(LGClockModel *)clock{
    
    __block LGClockModel *deleteModel;
    NSMutableArray<LGClockModel *> *tempAllClocks = [LGClockManager allClocks];
    [tempAllClocks enumerateObjectsUsingBlock:^(LGClockModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.ID isEqualToString:clock.ID]) {
            deleteModel = obj;
            *stop = YES;
        }
    }];
    if (deleteModel) {
        [tempAllClocks removeObject:deleteModel];
        //移除所有推送和缓存
        if (tempAllClocks.count == 0) {
            [[LGClockManager shareManager] removeAllClock];
        }else{
            [LGClockManager saveUserDefaultClocks:tempAllClocks];
        }
    }
}

/**
 把闹钟数组本地化
 
 @param clocks 闹钟数组
 */
+ (void)saveUserDefaultClocks:(NSMutableArray<LGClockModel *> *)clocks{
    
    [[NSUserDefaults standardUserDefaults] setObject:[LGClockModel mj_keyValuesArrayWithObjectArray:clocks] forKey:CLOCK_KEY];
}


@end


