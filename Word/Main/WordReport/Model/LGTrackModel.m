//
//  LGTrackModel.m
//  Word
//
//  Created by Charles Cao on 2018/3/30.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGTrackModel.h"

@implementation LGTrackModel

+ (NSDictionary *)mj_objectClassInArray{
	return @{
			 @"package" : @"LGTracPackageModel",
			 @"rank" : @"LGTrackRankModel"
			 };
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
	return @{
			 @"everydayNew" : @"new"
			 };
}

- (NSString *)insistDay{
	return _insistDay.length == 0 ? @"0" : _insistDay;
}

@end


@implementation LGTracPackageModel

@end

@implementation LGTrackUserDataModel

@end

@implementation LGTrackRankModel

@end

@implementation LGTranckEvModel

@end


