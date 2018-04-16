//
//  LGBaiduOcrManager.h
//  Word
//
//  Created by Charles Cao on 2018/4/16.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LGBaiduOcrManager : NSObject

+ (void)requestWithImage:(UIImage *)image complete:(void(^)(NSString *string))complete;

@end

@interface LGBaiduTokenModel : NSObject

@property (nonatomic, copy) NSString *token;
//百度 token 一个月的有效期,时间戳
@property (nonatomic, assign) double createTime;

//是否有效,按25天比较
@property (nonatomic, assign) BOOL isValid;

@end
