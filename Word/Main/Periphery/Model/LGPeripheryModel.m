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

@end


@implementation LGLivePreviewModel

+ (NSDictionary *)mj_objectClassInArray{
	return @{
			 @"data" :@"LGRecentClassModel"
			 };
}

- (void)mj_keyValuesDidFinishConvertingToObject{
	
	 NSDateFormatter *courseDateFormatter = [NSDateFormatter new];
	[courseDateFormatter setDateFormat:@"yyyy-MM"];
	if (self.data.count > 0) {
		LGRecentClassModel *firstClass = self.data.firstObject;
		NSInteger month = [courseDateFormatter dateFromString:self.date].month;
		firstClass.month = [NSString stringWithFormat:@"%ld月\n课程",month];
	}
}

@end

@implementation LGRecentClassModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
	return @{
			 @"courseTime" : @"cnName",
			 @"teacherName" : @"listeningFile",
			 @"teacherImage" : @"article",
			 @"ID" : @"id",
             @"courseDescription" : @"alternatives"
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
			 @"courseType" : @"categoryId"
			 };
}

@end

@implementation LGCaseModel
@end

