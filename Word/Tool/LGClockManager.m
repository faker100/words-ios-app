//
//  LGClockManager.m
//  Word
//
//  Created by caoguochi on 2018/4/7.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGClockManager.h"
#import "NSDate+Utilities.h"

#define CLOCK_KEY        @"CLOCK_KEY"

@implementation LGClockManager

+ (instancetype)shareManager{
    static LGClockManager *mannager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mannager = [[LGClockManager alloc]init];
    });
    return mannager;
}

- (void)removeClock:(LGClockModel *)clock{
    
    __block NSMutableArray<LGClockModel *> *tempClockArray = [LGClockManager allClocks];
    [tempClockArray enumerateObjectsUsingBlock:^(LGClockModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.identifier isEqualToString:clock.identifier]) {
            [tempClockArray removeObject:obj];
            *stop = YES;
        }
    }];
    
    [LGClockManager saveClocks:tempClockArray];
    
    JPushNotificationIdentifier *identifier = [[JPushNotificationIdentifier alloc]init];
    identifier.identifiers = @[clock.identifier];
    [JPUSHService removeNotification:identifier];
    
}

- (void)updateClock:(LGClockModel *)clock{
    if (clock.isUse) {
        [[LGClockManager shareManager] addClock:clock completion:nil];
    }else{
        JPushNotificationIdentifier *identifier = [[JPushNotificationIdentifier alloc]init];
        identifier.identifiers = @[clock.identifier];
        [JPUSHService removeNotification:identifier];
    }
    
}

- (void)addClock:(LGClockModel *)clock completion:(void (^)(BOOL isSuccess))completion{
    
    //通知时间
    if (clock.week.count == 0) {
        JPushNotificationTrigger *trigger = [[JPushNotificationTrigger alloc] init];
        trigger.repeat = NO;
        
        NSDateComponents *clockComponents = [[NSDateComponents alloc] init];
       // clockComponents.timeZone = [NSTimeZone systemTimeZone];
        clockComponents.hour = clock.hour;
        clockComponents.minute = clock.minute;
        
        NSDate *date = [[NSDate currentCalendar]nextDateAfterDate:[NSDate date] matchingComponents:clockComponents options:NSCalendarMatchNextTime];
        
       
        if (@available(iOS 10.0, *)) {
            NSDateComponents *components = [[NSDate currentCalendar] componentsInTimeZone:[NSTimeZone systemTimeZone] fromDate:date];
            trigger.dateComponents = components;
        } else {
            date = [date convertToSystemTimeZoneDate];
            trigger.fireDate = date;
        }
        
        [self addNotification:trigger identifier:clock.identifier completion:^(id result) {
            if (completion) {
                completion(result);
            }
            //添加成功
            if (result) {
                NSMutableArray *temp = [[LGClockManager allClocks] mutableCopy];
                [temp addObject:clock];
                [LGClockManager saveClocks:temp];
            }
        }];
        
    }else if (clock.week.count == 7) {
        
        JPushNotificationTrigger *trigger = [[JPushNotificationTrigger alloc] init];
        trigger.repeat = YES;
        if (@available(iOS 10.0, *)) {
            NSDateComponents *components = [[NSDateComponents alloc] init];
            components.hour = clock.hour;
            components.minute = clock.minute;
            trigger.dateComponents = components;
        } else {
            //iOS8 8 9
            // Fallback on earlier versions
        }
        [self addNotification:trigger identifier:clock.identifier completion:^(id result) {
            if (completion) {
                completion(result != nil);
            }
            //添加成功
            if (result) {
                NSMutableArray *temp = [[LGClockManager allClocks] mutableCopy];
                [temp addObject:clock];
                [LGClockManager saveClocks:temp];
            }
        }];
        
    }else{
        if (@available(iOS 10.0, *)) {
           
            __block NSMutableArray<UNNotificationRequest *> *arr = [NSMutableArray array];
            [clock.week enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                 JPushNotificationTrigger *trigger = [[JPushNotificationTrigger alloc] init];
                trigger.repeat = YES;
                NSDateComponents *components = [[NSDateComponents alloc] init];
                components.hour = clock.hour;
                components.minute = clock.minute;
                components.weekday = obj.integerValue + 1 == 8 ? 1 : obj.integerValue + 1;
                trigger.dateComponents = components;
                [self addNotification:trigger identifier:clock.identifier completion:^(id result) {
                    if (result) {
                        [arr addObject:result];
                    }else{
                        *stop = YES;
                    }
                }];
            }];
            
            
            if (completion) {
                completion(clock.week.count == arr.count);
            }
            
            if (clock.week.count != arr.count) {
                //回滚，取消通知
                 JPushNotificationIdentifier *identifier = [[JPushNotificationIdentifier alloc]init];
                __block NSMutableArray *identifierArray  = [NSMutableArray array];
                [arr enumerateObjectsUsingBlock:^(UNNotificationRequest * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [identifierArray addObject:obj.identifier];
                }];
                identifier.identifiers = identifierArray;
                [JPUSHService removeNotification:identifier];
            }
        }
    }
}

- (void)addNotification:(JPushNotificationTrigger *)trigger identifier:(NSString *)identifier  completion:(void(^)(id result))completion{
    //内容
    JPushNotificationContent *content = [[JPushNotificationContent alloc] init];
    content.title = @"闹钟标题";
    content.subtitle = @"副标题";
    content.body = @"内容";
    content.badge = @(1);
    
    //通知
    JPushNotificationRequest *request = [[JPushNotificationRequest alloc] init];
    request.requestIdentifier = identifier;
    request.content = content;
    request.trigger = trigger;
    request.completionHandler = ^(id result) {
        if (completion) {
            completion(result);
        }
    };
    [JPUSHService addNotification:request];
}

+ (NSMutableArray<LGClockModel *> *)allClocks{
    id arr = [[NSUserDefaults standardUserDefaults] objectForKey:CLOCK_KEY];
    return arr ? [LGClockModel mj_objectArrayWithKeyValuesArray:arr] : [NSMutableArray array];
}

+ (void)saveClocks:(NSMutableArray<LGClockModel *> *)clocks{
    
    if (clocks.count == 0) {
        [JPUSHService removeNotification:nil];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:[LGClockModel mj_keyValuesArrayWithObjectArray:clocks] forKey:CLOCK_KEY];
}

@end

@implementation LGPushNotificationTrigger



@end

