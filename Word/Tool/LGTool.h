//
//  LGTool.h
//  Word
//
//  Created by Charles Cao on 2018/1/26.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <Foundation/Foundation.h>


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

@end
