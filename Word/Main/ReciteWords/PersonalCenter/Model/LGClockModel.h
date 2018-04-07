//
//  LGClockModel.h
//  Word
//
//  Created by Charles Cao on 2018/3/29.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LGClockModel : NSObject


@property (nonatomic, assign) NSInteger hour;
@property (nonatomic, assign) NSInteger minute;

//时间字符串
@property (nonatomic, copy) NSString *time;

//是否使用
@property (nonatomic, assign) BOOL isUse;

//星期数组, @"1" @"2" @"3" @"4" @"5" @"6" @"7"
@property (nonatomic, copy) NSArray<NSString *> *week;

//闹钟标识:创建时间戳
@property (nonatomic, copy) NSString *identifier;

- (instancetype)init;

//当前闹钟日期 
- (NSDate *)date;

/**
 星期字符串拼接

 */
- (NSString *)weakStr;

/**
 数字转换星期

 @"1" -> 星期一
 
 @param weekNum @"1"
 @return 星期一
 */
+ (NSString *)weekNumToString:(NSString *)weekNum;


@end


