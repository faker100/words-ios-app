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


+ (void)beginCountDownWithSecond:(NSInteger)second completion:(void(^)(NSInteger currtentSecond))completion{
	__block NSInteger timeout = second;
	//创建timer
	dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
	//设置1s触发一次，0s的误差
	dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
																					  //触发的事件
	dispatch_source_set_event_handler(_timer, ^{
		if(timeout<=0){ //倒计时结束，关闭
						//取消dispatch源
			dispatch_source_cancel(_timer);
		}
		else{
			timeout--;
			dispatch_async(dispatch_get_main_queue(), ^{
				//更新主界面的操作
				if (completion) {
					completion(timeout);
				}
			});
		}
	});
	//开始执行dispatch源
	dispatch_resume(_timer);
}
@end
