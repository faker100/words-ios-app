//
//  LGWordLibraryModel.m
//  Word
//
//  Created by Charles Cao on 2018/1/31.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGWordLibraryModel.h"

@implementation LGWordLibraryModel

+ (NSDictionary *)mj_objectClassInArray{
	return @{
			 @"child" : [LGChildWordLibraryModel class]
			 };
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
	return @{
			 @"ID" : @"id"
			 };
}

- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
	if ([property.name isEqualToString:@"type"]) {
		NSInteger type = [NSString stringWithFormat:@"%@",oldValue].integerValue;
		return @(type);
	}
	return oldValue;
}

@end

@implementation LGChildWordLibraryModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
	return @{
			 @"ID" : @"id"
			 };
}

@end
