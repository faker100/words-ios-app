//
//  ESGLView.h
//  kxmovie
//
//  Created by Kolyvan on 22.10.12.
//  Copyright (c) 2012 Konstantin Boukreev . All rights reserved.
//
//  https://github.com/kolyvan/kxmovie
//  this file is part of KxMovie
//  KxMovie is licenced under the LGPL v3, see lgpl-3.0.txt

#import <UIKit/UIKit.h>
#import  <AVFoundation/AVFoundation.h>


@interface VodGLView : UIView

- (id) initWithFrame:(CGRect)frame;


@property (nonatomic, strong)UIImageView *movieASImageView DEPRECATED_MSG_ATTRIBUTE("新版本不在用这个做渲染视频，而采用videoLayer");


/**
 若要修改显示模式，修改videoLayer的videoGravity属性
 */
@property (nonatomic, retain) AVSampleBufferDisplayLayer *videoLayer;


-(void)renderAsVideoByImage:(UIImage*)imageFrame;

-(void)receivedRawVideoFrame:(const uint8_t *)frame withSize:(uint32_t)frameSize;

@property(nonatomic,assign)CGFloat Oratio;

@end
