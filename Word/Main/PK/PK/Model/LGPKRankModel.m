//
//  LGPKRankModel.m
//  Word
//
//  Created by Charles Cao on 2018/3/13.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGPKRankModel.h"

@implementation LGPKRankModel

+ (NSDictionary *)mj_objectClassInArray{
	return	@{
				@"rankingList" : @"LGRank"
			};
}

- (void)mj_keyValuesDidFinishConvertingToObject{
	[LGUserManager shareManager].user = self.user;
}

- (LGUserModel *)user{
	if (!_user) {
		_user = [LGUserManager shareManager].user;
	}
	return _user;
}

@end

@implementation LGRank

@end
