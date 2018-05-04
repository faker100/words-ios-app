//
//  LGReportModel.h
//  Word
//
//  Created by caoguochi on 2018/4/5.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <Foundation/Foundation.h>

@class  LGWeekReportModel;
@interface LGReportModel : NSObject

@property (nonatomic, strong) LGWeekReportModel *week;
@property (nonatomic, copy) NSDictionary *data;

//自定义属性，解析data后的数组,前 15天
@property (nonatomic, strong)NSMutableArray <LGWeekReportModel *> *before;

//自定义属性，解析data后的数组,后15天
@property (nonatomic, strong)NSMutableArray <NSString *>  *after;

//自定义属性,转换所有时间
@property (nonatomic, strong)NSMutableArray <NSString *> *date;

@end

@interface LGWeekReportModel : NSObject

//所有
@property (nonatomic, copy) NSString *all;
//模糊
@property (nonatomic, copy) NSString *dim;
//忘记
@property (nonatomic, copy) NSString *forget;
//认识
@property (nonatomic, copy) NSString *know;
//熟识
@property (nonatomic, copy) NSString *knowWell;
//不认识
@property (nonatomic, copy) NSString *notKnow;

@end
