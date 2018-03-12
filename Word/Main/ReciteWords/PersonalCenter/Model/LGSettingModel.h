//
//  LGSettingModel.h
//  Word
//
//  Created by Charles Cao on 2018/3/12.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSUInteger, LGSettingModelType) {
	LGSettingHeadImage,		 //头像
	LGSettingMore,			 //带箭头
	LGSettingNoMore,		 //不带箭头
};

@interface LGSettingModel : NSObject

@property (nonatomic, copy) NSString *infoTitle;
@property (nonatomic, copy) NSString *info;
@property (nonatomic, assign) LGSettingModelType type;

@end
