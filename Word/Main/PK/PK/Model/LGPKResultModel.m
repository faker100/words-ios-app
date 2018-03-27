//
//  LGPKResultModel.m
//  Word
//
//  Created by Charles Cao on 2018/3/27.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGPKResultModel.h"

@implementation LGPKResultModel

+ (NSDictionary *)mj_objectClassInArray{
	return @{
			 @"data" : @"LGPKRighOrWrongModel"
			 };
}

@end

@implementation LGPKRighOrWrongModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
	return @{
			 @"aFalse" : @"false",
			 @"aTrue" : @"true"
			 };
}

@end
