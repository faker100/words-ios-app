//
//  LGTool.m
//  Word
//
//  Created by Charles Cao on 2018/1/26.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGTool.h"
#import <AVFoundation/AVCaptureDevice.h>
#import <Photos/PHPhotoLibrary.h>

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


+ (dispatch_source_t)beginCountDownWithSecond:(NSInteger)second completion:(void(^)(NSInteger currtentSecond))completion{
	__block NSInteger timeout = second;
	//创建一个并发队列
	dispatch_queue_t queue = dispatch_queue_create("countDown", DISPATCH_QUEUE_CONCURRENT);
	//创建timer
	dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
	//设置1s触发一次，0s的误差
	dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
																					  //触发的事件
	dispatch_source_set_event_handler(_timer, ^{
		if(timeout<0){ //倒计时结束，关闭
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
	return _timer;
}


+ (BOOL)checkDevicePermissions:(LGDevicePermissionsType)type{
	
	__block BOOL flag = YES;
	
	NSString *message = @"";
	
	if (type == LGDeviceCamera) {
		AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
		if (status == AVAuthorizationStatusRestricted || status == AVAuthorizationStatusDenied) {
			flag = NO;
			message = @"请在iPhone的\"设置-隐私-相机\"选项中,允许访问你的相机";
		}
	}
	
	
	if (type == LGDevicePhotosAlbum) {
		PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
		if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied) {
			flag = NO;
			message = @"请在iPhone的\"设置-隐私-照片\"选项中,允许访问你的照片";
		}

	}
	
	if (type == LGDeviceMicrophone) {
		AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
		if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied) {
			flag = NO;
			message = @"请在iPhone的\"设置-隐私-麦克风\"选项中,允许访问你的麦克风";
		}
	}
	
	if (!flag) {
		
		UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
		[alertController addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:nil]];
		[alertController addAction:[UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault  handler:^(UIAlertAction * _Nonnull action) {
			NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
			if ([[UIApplication sharedApplication] canOpenURL:url]) {
				[[UIApplication sharedApplication] openURL:url];
			}
		}]];
		[[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:alertController animated:YES completion:nil];
	}
	
	return flag;
}

@end
