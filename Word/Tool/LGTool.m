//
//  LGTool.m
//  Word
//
//  Created by Charles Cao on 2018/1/26.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGTool.h"

@implementation LGTool


+ (UIImage *)createImageWithColor:(UIColor *)color size:(CGSize)size;
{
	CGRect rect=CGRectMake(0.0f, 0.0f, size.width, size.height);
	UIGraphicsBeginImageContext(rect.size);
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetFillColorWithColor(context, [color CGColor]);
	CGContextFillRect(context, rect);
	
	UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return theImage;
}

+ (NSString *)getAudioFilePath {
	
	NSFileManager *fileManager = [[NSFileManager alloc] init];
	NSString *pathDocument = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
	NSString *audioPath = [pathDocument stringByAppendingPathComponent:@"AudioFile"];
	// 判断文件夹是否存在，如果不存在，则创建
	if (![[NSFileManager defaultManager] fileExistsAtPath:audioPath]) {
		NSError *error;
		[fileManager createDirectoryAtPath:audioPath withIntermediateDirectories:YES attributes:nil error:&error];
		return error ? nil : audioPath;
	}
	return audioPath;
}

@end
