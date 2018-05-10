//
//  LGPeripheryModel.m
//  Word
//
//  Created by Charles Cao on 2018/4/8.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGPeripheryModel.h"
#import "NSDate+Utilities.h"

@implementation LGPeripheryModel

+ (NSDictionary *)mj_objectClassInArray{
	return @{
			 @"recentClass" : @"LGRecentClassModel",
			 @"livePreview" : @"LGLivePreviewModel",
			 @"choiceness" 	: @"LGChoicenessModel",
			 @"aCase"		: @"LGCaseModel"
			 };
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"aCase" : @"case"};
}

- (void)mj_keyValuesDidFinishConvertingToObject{
    
    //筛选未直播的预告
   __block NSMutableArray <LGLivePreviewModel *> *tempLiveArr = [NSMutableArray array];
    
    NSDateFormatter *dateFormatter = [LGLivePreviewModel getDateFormatter];
    [self.livePreview enumerateObjectsUsingBlock:^(LGLivePreviewModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger month = [dateFormatter dateFromString:obj.date].month;
        NSDate *today = [NSDate currentDate];
        if (month == today.month) {
            __block NSMutableArray<LGRecentClassModel *> *tempRecentClassArr = [NSMutableArray array];
            [obj.data enumerateObjectsUsingBlock:^(LGRecentClassModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                static NSDateFormatter *courseTimeForMatter;
                if (!courseTimeForMatter) {
                    courseTimeForMatter = [NSDateFormatter new];
                    [courseTimeForMatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                    [courseTimeForMatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
                }
                if ([[courseTimeForMatter dateFromString:obj.courseTime] isToday]) {
                    [tempRecentClassArr addObject:obj];
                }
            }];
            if (tempRecentClassArr.count > 0) {
                obj.data = tempRecentClassArr;
                [tempLiveArr addObject:obj];
            }
            
        }else if (month > today.month){
            [tempLiveArr addObject:obj];
        }
    }];
    self.livePreview = tempLiveArr;
}

@end


@implementation LGLivePreviewModel

+ (NSDictionary *)mj_objectClassInArray{
	return @{
			 @"data" :@"LGRecentClassModel"
			 };
}

- (void)mj_keyValuesDidFinishConvertingToObject{
	
	 NSDateFormatter *courseDateFormatter = [LGLivePreviewModel getDateFormatter];
	
	if (self.data.count > 0) {
		LGRecentClassModel *firstClass = self.data.firstObject;
		NSInteger month = [[courseDateFormatter dateFromString:self.date] convertToSystemTimeZoneDate].month;
		firstClass.month = [NSString stringWithFormat:@"%ld月\n课程",month];
	}
}

+ (NSDateFormatter *)getDateFormatter{
    static NSDateFormatter *courseDateFormatter;
    if(!courseDateFormatter){
        courseDateFormatter = [NSDateFormatter new];
        [courseDateFormatter setDateFormat:@"yyyy-MM"];
        [courseDateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    };
    return courseDateFormatter;
}

@end

@implementation LGRecentClassModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
	return @{
			 @"courseTime" : @"cnName",
			 @"teacherName" : @"listeningFile",
			 @"teacherImage" : @"article",
			 @"ID" : @"id",
             @"courseDescription" : @"alternatives",
			 @"courseDescriptionHTML" : @"sentenceNumber"
			 };
}

@end


@implementation LGChoicenessModel

- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    
    if ([property.name isEqualToString:@"courseType"]) {
        NSString *temp = (NSString *)oldValue;
        return @(temp.integerValue);
    }
    return oldValue;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
	return @{
			 @"courseType" : @"categoryId",
			 @"ID" : @"id"
			 };
}

- (NSString *)viewNum{
	NSDate *date = [[NSDate defaultDateFormatter] dateFromString:@"2018-4-23"];
	NSInteger distance = [date distanceInDaysToDate:[NSDate currentDate]];
	return @(distance * (50 - self.ID.integerValue) +  234).stringValue;
}

@end

@implementation LGCaseModel
@end

