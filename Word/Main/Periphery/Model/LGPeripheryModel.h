//
//  LGPeripheryModel.h
//  Word
//
//  Created by Charles Cao on 2018/4/8.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LGRecentClassModel, LGLivePreviewModel, LGCaseModel, LGChoicenessModel;
@interface LGPeripheryModel : NSObject

@property (nonatomic, copy) NSArray<LGRecentClassModel *> *recentClass;
@property (nonatomic, copy) NSArray<LGLivePreviewModel *> *livePreview;
@property (nonatomic, copy) NSArray<LGChoicenessModel *>  *choiceness;
@property (nonatomic, copy) NSArray<LGCaseModel *> *aCase;

@end

@interface LGLivePreviewModel : NSObject

@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSArray<LGRecentClassModel *> *data;

+ (NSDateFormatter *)getDateFormatter;

@end

//最近课程
@interface LGRecentClassModel : NSObject

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *viewCount;

@property (nonatomic, copy) NSString *title;
//课程类型
@property (nonatomic, copy) NSString *catName;

//课程时间
@property (nonatomic, copy) NSString *courseTime;

//课程简介 不带 html 标签
@property (nonatomic, copy) NSString *courseDescription;

//课程简介 带 html标签
@property (nonatomic, copy) NSString *courseDescriptionHTML;

@property (nonatomic, copy) NSString *teacherImage;

@property (nonatomic, copy) NSString *teacherName;

//自定义字段,几月课程,直播预告中,每个 section 第一个 cell 有
@property (nonatomic, copy) NSString *month;

@end


//经典课程
@interface LGChoicenessModel : NSObject

@property (nonatomic, copy) NSString *ID;

//根据categoryId转换
@property (nonatomic, assign) LGCourseType courseType;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *url;

@end

@interface LGCaseModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *content;
@end


