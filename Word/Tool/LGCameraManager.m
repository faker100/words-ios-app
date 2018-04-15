//
//  LGCameraManager.m
//  Word
//
//  Created by caoguochi on 2018/4/15.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGCameraManager.h"

@interface LGCameraManager ()

@property (nonatomic, strong) AVCaptureDevice *device;

@property (nonatomic, strong) AVCaptureDeviceInput *deviceInput;

@property (nonatomic, strong) AVCaptureStillImageOutput *imageOutput;

@property (nonatomic, strong) AVCaptureSession *session;

@end

@implementation LGCameraManager


@synthesize previewLayer = _previewLayer;

- (instancetype)init {
    if (self = [super init]) {
        _devicePosition = AVCaptureDevicePositionBack;
    }
    return self;
}

- (void)reload {
    [self.session stopRunning];
    self.session = nil;
    self.imageOutput = nil;
    self.deviceInput = nil;
    self.device = nil;
    [self.session startRunning];
    self.previewLayer.session = self.session;
}

- (void)setDevicePosition:(AVCaptureDevicePosition)devicePosition {
    if (_devicePosition == devicePosition) {
        return;
    }
    BOOL containDevicePostion = false;
    NSArray <AVCaptureDevice *> *deviceArray = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in deviceArray) {
        if (device.position == devicePosition) {
            containDevicePostion = true;
            break;
        }
    }
    if (containDevicePostion) {
        _devicePosition = devicePosition;
        [self reload];
    }
}

- (void)setOpenFlashLight:(BOOL)openFlashLight {
    if (_openFlashLight == openFlashLight) {
        return;
    }
    if (self.device.hasTorch || self.device.hasFlash) {
        [self.device lockForConfiguration:nil];
        AVCaptureTorchMode torchMode = openFlashLight ? AVCaptureTorchModeOn : AVCaptureTorchModeOff;
        AVCaptureFlashMode flashMode = openFlashLight ? AVCaptureFlashModeOn : AVCaptureFlashModeOff;
        if (self.device.hasTorch) {
            [self.device setTorchMode:torchMode];
            _openFlashLight = openFlashLight;
        } else if (self.device.hasFlash) {
            [self.device setFlashMode:flashMode];
            _openFlashLight = openFlashLight;
        }
        [self.device unlockForConfiguration];
    }
}

- (void)cutCameraImageDataComplete:(void(^)(NSData *imageData))complete {
    AVCaptureConnection *videoConnection = [self.imageOutput connectionWithMediaType:AVMediaTypeVideo];
    [self.imageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        if (complete) {
            if (imageDataSampleBuffer) {
                NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
                complete(imageData);
            } else {
                complete(nil);
            }
        }
    }];
}


#pragma mark - getter setter

- (AVCaptureDevice *)device {
    if (!_device) {
        NSArray <AVCaptureDevice *> *deviceArray = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
        for (AVCaptureDevice *device in deviceArray) {
            if (device.position == self.devicePosition) {
                _device = device;
                break;
            }
        }
    }
    return _device;
}

- (AVCaptureDeviceInput *)deviceInput {
    if (!_deviceInput) {
        _deviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:self.device error:nil];
    }
    return _deviceInput;
}

- (AVCaptureStillImageOutput *)imageOutput {
    if (!_imageOutput) {
        _imageOutput = [[AVCaptureStillImageOutput alloc] init];
    }
    return _imageOutput;
}

- (AVCaptureSession *)session {
    if (!_session) {
        _session = [[AVCaptureSession alloc] init];
        if ([_session canAddInput:self.deviceInput]) {
            [_session addInput:self.deviceInput];
        }
        if ([_session canAddOutput:self.imageOutput]) {
            [_session addOutput:self.imageOutput];
        }
    }
    return _session;
}

- (AVCaptureVideoPreviewLayer *)previewLayer {
    if (!_previewLayer) {
        _previewLayer = [[AVCaptureVideoPreviewLayer alloc] init];
        _previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        _previewLayer.frame = [UIScreen mainScreen].bounds;
    }
    return _previewLayer;
}

@end
