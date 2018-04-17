//
//  LGCameraManager.h
//  Word
//
//  Created by caoguochi on 2018/4/15.
//  Copyright © 2018年 Charles. All rights reserved.
//

/*
 * 别人写的demo
 */

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface LGCameraManager : NSObject

@property (nonatomic, strong, readonly) AVCaptureVideoPreviewLayer *previewLayer;

@property (nonatomic, assign) AVCaptureDevicePosition devicePosition;

@property (nonatomic, strong) AVCaptureSession *session;

@property (nonatomic, assign, getter=flashLightIsOpening) BOOL openFlashLight;

- (void)reload;

- (void)cutCameraImageDataComplete:(void(^)(NSData *imageData))complete;

@end
