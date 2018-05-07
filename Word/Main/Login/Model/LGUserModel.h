//
//  LGUserModel.h
//  Word
//
//  Created by Charles Cao on 2018/1/20.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <Foundation/Foundation.h>

#define LGUSER_ISREVIEW_KEY  @"LGUSER_ISREVIEW_KEY"
#define FONT_SIZE_KEY	     @"FONT_SIZE_KEY"
#define EMAIL_KEY			 @"EMAIL_KEY"
#define PHONE_KEY			 @"PHONE_KEY"
#define NICKNAME_KEY		 @"NICKNAME_KEY"
#define PASSWORD_KEY		 @"PASSWORD_KEY"

@interface LGUserModel : NSObject


@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *lastSign; //最后打卡时间
@property (nonatomic, copy) NSString *startTime; //第一次背单词时间;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *lose;  //pk 失败次数
@property (nonatomic, copy) NSString *win;	 //pk 胜利次数
@property (nonatomic, copy) NSString *estimateWords;  // 单词评估量,pk的model为word字段
@property (nonatomic, copy) NSString *fontSize;   //设置中的字体大小
@property (nonatomic, assign) LGStudyType  studyModel; //用户学习模式;
@property (nonatomic, copy) NSString *planWords; //判断用户当前词包是否有计划; nil 没有计划
@property (nonatomic, assign) BOOL isTodayReview; //是否已经看过首页今日复习弹框


@end
