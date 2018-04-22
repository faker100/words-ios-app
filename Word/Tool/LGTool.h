//
//  LGTool.h
//  Word
//
//  Created by Charles Cao on 2018/1/26.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, LGDevicePermissionsType) {
	LGDevicePhotosAlbum,  //相册权限
	LGDeviceCamera, 	  //相机权限
	LGDeviceMicrophone,   //麦克风权限
    LGDeviceNotification  //通知权限
};

@interface LGTool : NSObject

/**
 UIColor 转换 UIImage
 *
 */
+ (UIImage *)createImageWithColor:(UIColor *)color size:(CGSize)size;


/**
 获取音频缓存路径

 @return 路径
 */
+ (NSString *)getAudioFilePath;


/**
 倒计时

 @param second 倒计时秒数
 @param completion 每秒回调一次
 
 @return 时间源, 可以用于取消时间
 */
+ (dispatch_source_t)beginCountDownWithSecond:(NSInteger)second completion:(void(^)(NSInteger currtentSecond))completion;



/**
  计时器,从0开始

 @param completion 每秒回调一次
 @return 时间源, 可以用于取消时间
 */
+ (dispatch_source_t)timerCompletion:(void(^)(NSInteger currtentSecond))completion;



/**
 取消计时

 */
+ (void)cancelTimer:(dispatch_source_t)timer;

/**
 判断设备是否有访问相机/相册/麦克风等权限,并可以跳转到设置

 @param type 权限
 @return YES-有  NO-没有
 */
+ (BOOL)checkDevicePermissions:(LGDevicePermissionsType) type;


/**
 从view 截屏

 @param view 截图的view
 
 */
+ (UIImage *)screenshotFromView:(UIView *)view;


@end
