//
//  LGJpushReceiveMessageModel.m
//  Word
//
//  Created by Charles Cao on 2018/3/22.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGJPushReceiveMessageModel.h"

@implementation LGJPushReceiveMessageModel

@end


@implementation LGExtrasModel

- (void)mj_keyValuesDidFinishConvertingToObject{
	if (self.type == 1) {
		self.message = [LGMatchModel mj_objectWithKeyValues:self.message];
	}
}

@end


@implementation LGMatchModel

@end

@implementation LGMatchUserModel

@end
