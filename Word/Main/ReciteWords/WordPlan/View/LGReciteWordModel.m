//
//  LGReciteWordModel.m
//  Word
//
//  Created by caoguochi on 2018/2/6.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGReciteWordModel.h"

@implementation LGReciteWordModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"ID":@"id",
             @"todayWords" : @"toDayWords"
             };
}

@end

@implementation LGUserPackage

@end
