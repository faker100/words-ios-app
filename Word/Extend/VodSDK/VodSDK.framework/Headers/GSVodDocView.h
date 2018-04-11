//
//  GSVodDocView.h
//  VodSDK
//
//  Created by jiangcj on 16/7/6.
//  Copyright © 2016年 gensee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GSVodDocSwfView.h"


@protocol GSVodDocViewDelegate <NSObject>

@optional

- (void)docVodViewOpenFinishSuccess:(GSVodDocPage*)page ;

@end


@interface GSVodDocView : UIScrollView


/**
 *  设置文档是否支持pinch手势，YES表示支持
 */
@property (assign, nonatomic) BOOL zoomEnabled;



/**
 *  设置isVectorScale值，在打开缩放功能的情况下，使用这个这个变量进行缩放方式的选择，yes表示是矢量放大，no表示是一般放大，默认是yes矢量放大
 */
@property (assign, nonatomic)BOOL isVectorScale;





/**
 *  文档退出前清理一下文档模块
 */
-(void)clearVodLastPageAndAnno;




//文档打开代理
@property (nonatomic, weak)id<GSVodDocViewDelegate> vodDocDelegate;



/**
 *  初始化GSVodPDocView
 *
 *  @param frame 设置GSPDocView的宽高，坐标等信息
 *
 *  @return GSVodPDocView实例
 */
- (id)initWithFrame:(CGRect)frame;



@property (strong, nonatomic)GSVodDocSwfView *vodDocSwfView;




- (void)drawPage:(unsigned int)dwTimeStamp
            data:(const unsigned char*)data
           dwLen:(unsigned int )dwLen
         dwPageW:(unsigned int )dwPageW
         dwPageH:(unsigned int )dwPageH
   strAnimations:(NSString*)strAnimations;

-(void)vodGoToAnimationStep:(int)step;

- (void)vodDrawAnnos:(NSArray*)annos;

-(void)setGlkBackgroundColor:(int)red green:(int)green blue:(int)blue;




/**
 *  设置文档文档的显示类型
 */
@property(assign,nonatomic)GSVodDocShowType  gSDocModeType; //文档的显示类型



@end
