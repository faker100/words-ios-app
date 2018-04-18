//
//  LGImageSearchController.m
//  Word
//
//  Created by caoguochi on 2018/4/15.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGImageSearchController.h"
#import "LGCameraManager.h"
#import "LGBaiduOcrManager.h"
#import "LGSearchController.h"
#import "LGWordDetailController.h"
#import "LGTool.h"
#import "AipCutImageView.h"
#import "AipImageView.h"
#import "UIImage+AipCameraAddition.h"
#import "LGNavigationController.h"

#define V_X(v)      v.frame.origin.x
#define V_Y(v)      v.frame.origin.y
#define V_H(v)      v.frame.size.height
#define V_W(v)      v.frame.size.width

//拖动手势开始点击区域，根据不同区域，裁剪区域
typedef NS_ENUM(NSUInteger, LGPanTouchZone) {
    LGPanTouchZoneNone,
    LGPanTouchZoneTop,
    LGPanTouchZoneLeft,
    LGPanTouchZoneBottom,
    LGPanTouchZoneRight,
    LGPanTouchZoneLeftTop,
    LGPanTouchZoneRightTop,
    LGPanTouchZoneleftBottom,
    LGPanTouchZoneRightBottom,
    LGPanTouchZoneWidth,
    LGPanTouchZoneHeight
};

@interface LGImageSearchController () <LGTextSearchControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    LGPanTouchZone zone;
    CGPoint lastPanPoint;
}

@property (nonatomic, strong) LGCameraManager *cameraManager;
@property (nonatomic, strong) LGSearchController *searchController;

@property (assign, nonatomic) UIImageOrientation imageOrientation;
@property (assign, nonatomic) UIDeviceOrientation imageDeviceOrientation;

@property (weak, nonatomic) IBOutlet AipCutImageView *cutImageView;
@property (weak, nonatomic) IBOutlet AipImageView *maskImageView;
@property (assign, nonatomic) CGSize size;


@property (weak, nonatomic) IBOutlet UIView *cutPhotoToolView;

@end

@implementation LGImageSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[self setUpMaskImageView];
    self.cameraManager = [LGCameraManager new];
    [self.cameraManager reload];
	[self.view.layer insertSublayer:self.cameraManager.previewLayer atIndex:0];
    [self touchZoneWithPoint:CGPointZero];
	self.title = @"";
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	[self.navigationController setNavigationBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.cameraManager.openFlashLight = NO;
	[self.navigationController setNavigationBarHidden:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 拖动拍照时的裁剪区域

 */
- (IBAction)panCutViewAction:(UIPanGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
    
       CGPoint touchPoint = [sender.view convertPoint:[sender locationInView:sender.view] toView:self.cutView];
        zone  = [self touchZoneWithPoint:touchPoint];
        lastPanPoint = CGPointZero;
    }else if(sender.state == UIGestureRecognizerStateChanged){
        
        CGPoint point = [sender translationInView:sender.view];
        
        CGFloat change_x = point.x - lastPanPoint.x;
        CGFloat change_y = point.y - lastPanPoint.y;
        
        if (zone == LGPanTouchZoneWidth) {
            zone = change_x > 0 ? LGPanTouchZoneRight : LGPanTouchZoneLeft;
        }
        if (zone == LGPanTouchZoneHeight){
            zone = change_y > 0 ? LGPanTouchZoneBottom : LGPanTouchZoneTop;
        }
    
        lastPanPoint = point;
        
        
        switch (zone) {
            case LGPanTouchZoneTop:
                self.cutViewHeightConstraint.constant -= change_y;
                break;
            case LGPanTouchZoneLeft:
                self.cutViewWidthConstraint.constant -= change_x;
                break;
            case LGPanTouchZoneBottom:
                self.cutViewHeightConstraint.constant += change_y;
                break;
            case LGPanTouchZoneRight:
                self.cutViewWidthConstraint.constant += change_x;
                break;
            case LGPanTouchZoneLeftTop:
                self.cutViewHeightConstraint.constant -= change_y;
                self.cutViewWidthConstraint.constant -= change_x;
                break;
            case LGPanTouchZoneRightTop:
                self.cutViewHeightConstraint.constant -= change_y;
                self.cutViewWidthConstraint.constant += change_x;
                break;
            case LGPanTouchZoneleftBottom:
                self.cutViewHeightConstraint.constant += change_y;
                self.cutViewWidthConstraint.constant -= change_x;
                break;
            case LGPanTouchZoneRightBottom:
                self.cutViewHeightConstraint.constant += change_y;
                self.cutViewWidthConstraint.constant  += change_x;
                break;
            case LGPanTouchZoneWidth:
                
                self.cutViewWidthConstraint.constant  += change_x;
                break;
            default:
                break;
        }
		
		//高宽最小 50;
		if (self.cutViewWidthConstraint.constant <= 50) self.cutViewWidthConstraint.constant = 50;
		if (self.cutViewHeightConstraint.constant <= 50) self.cutViewHeightConstraint.constant = 50;
		
        [UIView animateWithDuration:0 animations:^{
            [self.cutView layoutIfNeeded];
        }];
        
    }else if(sender.state == UIGestureRecognizerStateEnded){
        zone = LGPanTouchZoneNone;
    }
}


/**
 根据 pan 手势点击区域,判断拖动区域

 @param point 起始点
 */
- (LGPanTouchZone)touchZoneWithPoint:(CGPoint)point{
    
    CGFloat cutViewHeight = CGRectGetHeight(self.cutView.bounds);
    CGFloat cutViewWidth = CGRectGetWidth(self.cutView.bounds);
    
    if (cutViewWidth < 50) return LGPanTouchZoneWidth;
    if (cutViewHeight < 50) return LGPanTouchZoneHeight;
    
    CGRect leftTopRect = CGRectMake(-25, -25, 50, 50);
    CGRect rightTopRect = CGRectMake(cutViewWidth - 25, -25, 50, 50);
    CGRect leftBottomRect = CGRectMake(-25, cutViewHeight - 25, 50, 50);
    CGRect rightBottomRect = CGRectMake(cutViewWidth - 25, cutViewHeight - 25, 50, 50);
    
    CGRect topRect = CGRectMake(25, -25, cutViewWidth - 2 * 25, 50);
    CGRect leftRect = CGRectMake(-25, 25, 50, cutViewHeight - 2 * 25);
    CGRect bottomRect = CGRectMake(25, cutViewHeight - 25, cutViewWidth - 2 * 25, 50);
    CGRect rightRect = CGRectMake(cutViewWidth - 25, 25, 50, cutViewHeight - 2 * 25);
    
	
    if (CGRectContainsPoint(leftTopRect, point))     return  LGPanTouchZoneLeftTop;
    if (CGRectContainsPoint(rightTopRect, point))    return  LGPanTouchZoneRightTop;
    if (CGRectContainsPoint(leftBottomRect, point))  return  LGPanTouchZoneleftBottom;
    if (CGRectContainsPoint(rightBottomRect, point)) return  LGPanTouchZoneRightBottom;
    if (CGRectContainsPoint(topRect, point))         return  LGPanTouchZoneTop;
    if (CGRectContainsPoint(leftRect, point))        return  LGPanTouchZoneLeft;
    if (CGRectContainsPoint(bottomRect, point))      return  LGPanTouchZoneBottom;
    if (CGRectContainsPoint(rightRect, point))       return  LGPanTouchZoneRight;
    
    return LGPanTouchZoneNone;
}

- (IBAction)photographAction:(id)sender {


	[self.cameraManager cutCameraImageDataComplete:^(NSData *imageData) {

		UIImage *originImage = [UIImage imageWithData:imageData];

		CGFloat scale = [UIScreen mainScreen].scale;
		//缩小原图
		CGFloat scaleSize = SCREEN_WIDTH / originImage.size.width;
		UIGraphicsBeginImageContextWithOptions(CGSizeMake(originImage.size.width * scaleSize, originImage.size.height * scaleSize), NO, scale);
		[originImage drawInRect:self.view.bounds];
		UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();
		
		
		//根据屏幕比率,换算裁剪区域
		CGRect cutViewRect = self.cutView.frame;
		cutViewRect = CGRectMake( CGRectGetMinX(cutViewRect) * scale, CGRectGetMinY(cutViewRect) * scale, CGRectGetWidth(cutViewRect) * scale, CGRectGetHeight(cutViewRect) * scale);
		
 		//裁剪
		CGImageRef imageRef = CGImageCreateWithImageInRect([scaledImage CGImage], cutViewRect);
		UIImage * cutImage = [UIImage imageWithCGImage:imageRef];
		CGImageRelease(imageRef);
		//请求
		[self requestWithImage:cutImage];
	}];
}

- (IBAction)dismissAction:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

//相册
- (IBAction)photoLibraryAction:(id)sender {
    if ([LGTool checkDevicePermissions:LGDevicePhotosAlbum]) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        [self.navigationController presentViewController:imagePicker animated:YES completion:nil];
    }
}

- (IBAction)lightAction:(id)sender {
    self.cameraManager.openFlashLight = !self.cameraManager.openFlashLight;
}

//设置背景图
- (void)setupCutImageView:(UIImage *)image fromPhotoLib:(BOOL)isFromLib {
	
	if (isFromLib) {
		self.cutImageView.userInteractionEnabled = YES;
	}else{
		self.cutImageView.userInteractionEnabled = NO;
	}
	[self.cutImageView setBGImage:image fromPhotoLib:isFromLib useGestureRecognizer:NO];
	self.cutImageView.hidden = NO;
	self.maskImageView.hidden = NO;
	self.cutPhotoToolView.hidden = NO;
}

//设置相册模式裁剪框
- (void)setUpMaskImageView {
	
	self.maskImageView.showMidLines = YES;
	self.maskImageView.needScaleCrop = YES;
	self.maskImageView.showCrossLines = YES;
	self.maskImageView.cropAreaCornerWidth = 30;
	self.maskImageView.cropAreaCornerHeight = 30;
	self.maskImageView.minSpace = 30;
	self.maskImageView.cropAreaCornerLineColor = [UIColor colorWithWhite:1 alpha:1];
	self.maskImageView.cropAreaBorderLineColor = [UIColor colorWithWhite:1 alpha:0.7];
	self.maskImageView.cropAreaCornerLineWidth = 3;
	self.maskImageView.cropAreaBorderLineWidth = 1;
	self.maskImageView.cropAreaMidLineWidth = 30;
	self.maskImageView.cropAreaMidLineHeight = 1;
	self.maskImageView.cropAreaCrossLineColor = [UIColor colorWithWhite:1 alpha:0.5];
	self.maskImageView.cropAreaCrossLineWidth = 1;
	self.maskImageView.cropAspectRatio = 662/1010.0;
	
}

//关闭裁剪照片
- (IBAction)closeCutPhotoAction:(id)sender {
	self.cutImageView.hidden = YES;
	self.maskImageView.hidden = YES;
	self.cutPhotoToolView.hidden = YES;
}


- (IBAction)pressTransform:(id)sender {
	
	//向右转90'
	self.cutImageView.bgImageView.transform = CGAffineTransformRotate (self.cutImageView.bgImageView.transform, M_PI_2);
	if (self.imageOrientation == UIImageOrientationUp) {
		
		self.imageOrientation = UIImageOrientationRight;
	}else if (self.imageOrientation == UIImageOrientationRight){
		
		self.imageOrientation = UIImageOrientationDown;
	}else if (self.imageOrientation == UIImageOrientationDown){
		
		self.imageOrientation = UIImageOrientationLeft;
	}else{
		
		self.imageOrientation = UIImageOrientationUp;
	}
	
}

//上传图片识别结果
- (IBAction)pressCheckChoose:(id)sender {
	
	
	CGRect rect  = [self transformTheRect];
	
	UIImage *cutImage = [self.cutImageView cutImageFromView:self.cutImageView.bgImageView withSize:self.size atFrame:rect];
	
	UIImage *image = [UIImage sapicamera_rotateImageEx:cutImage.CGImage byDeviceOrientation:self.imageDeviceOrientation];
	
	UIImage *finalImage = [UIImage sapicamera_rotateImageEx:image.CGImage orientation:self.imageOrientation];
	
	[self requestWithImage:finalImage];
	
}

//请求
- (void)requestWithImage:(UIImage *)image{
	[LGProgressHUD showHUDAddedTo:self.view];
	[LGBaiduOcrManager requestWithImage:image complete:^(NSString *string) {
		[LGProgressHUD hideHUDForView:self.view];
		if (string.length > 0) {
			self.searchController = [[LGSearchController alloc]initWithText:string delegate:self];
			[self.navigationController presentViewController:self.searchController animated:YES completion:nil];
		}else{
			[LGProgressHUD showMessage:@"解析失败" toView:self.view];
		}
	}];
}

- (CGRect)transformTheRect{
	
	CGFloat x;
	CGFloat y;
	CGFloat width;
	CGFloat height;
	
	CGFloat cropAreaViewX = V_X(self.maskImageView.cropAreaView);
	CGFloat cropAreaViewY = V_Y(self.maskImageView.cropAreaView);
	CGFloat cropAreaViewW = V_W(self.maskImageView.cropAreaView);
	CGFloat cropAreaViewH = V_H(self.maskImageView.cropAreaView);
	
	CGFloat bgImageViewX  = V_X(self.cutImageView.bgImageView);
	CGFloat bgImageViewY  = V_Y(self.cutImageView.bgImageView);
	CGFloat bgImageViewW  = V_W(self.cutImageView.bgImageView);
	CGFloat bgImageViewH  = V_H(self.cutImageView.bgImageView);
	
	if (self.imageOrientation == UIImageOrientationUp) {
		
		
		if (cropAreaViewX< bgImageViewX) {
			
			x = 0;
			width = cropAreaViewW - (bgImageViewX - cropAreaViewX);
		}else{
			
			x = cropAreaViewX-bgImageViewX;
			width = cropAreaViewW;
		}
		
		if (cropAreaViewY< bgImageViewY) {
			
			y = 0;
			height = cropAreaViewH - (bgImageViewY - cropAreaViewY);
		}else{
			
			y = cropAreaViewY-bgImageViewY;
			height = cropAreaViewH;
		}
		
		self.size = CGSizeMake(bgImageViewW, bgImageViewH);
	}else if (self.imageOrientation == UIImageOrientationRight){
		
		if (cropAreaViewY<bgImageViewY) {
			
			x = 0;
			width = cropAreaViewH - (bgImageViewY - cropAreaViewY);
		}else{
			
			x = cropAreaViewY - bgImageViewY;
			width = cropAreaViewH;
		}
		
		CGFloat newCardViewX = cropAreaViewX + cropAreaViewW;
		CGFloat newBgImageViewX = bgImageViewX + bgImageViewW;
		
		if (newCardViewX>newBgImageViewX) {
			y = 0;
			height = cropAreaViewW - (newCardViewX - newBgImageViewX);
		}else{
			
			y = newBgImageViewX - newCardViewX;
			height = cropAreaViewW;
		}
		
		self.size = CGSizeMake(bgImageViewH, bgImageViewW);
	}else if (self.imageOrientation == UIImageOrientationLeft){
		
		if (cropAreaViewX < bgImageViewX) {
			
			y = 0;
			height = cropAreaViewW - (bgImageViewX - cropAreaViewX);
		}else{
			
			y = cropAreaViewX-bgImageViewX;
			height = cropAreaViewW;
		}
		
		CGFloat newCardViewY = cropAreaViewY + cropAreaViewH;
		CGFloat newBgImageViewY = bgImageViewY + bgImageViewH;
		
		if (newCardViewY< newBgImageViewY) {
			
			x = newBgImageViewY - newCardViewY;
			width = cropAreaViewH;
		}else{
			
			x = 0;
			width = cropAreaViewH - (newCardViewY - newBgImageViewY);
		}
		
		self.size = CGSizeMake(bgImageViewH, bgImageViewW);
	}else{
		
		CGFloat newCardViewX = cropAreaViewX + cropAreaViewW;
		CGFloat newBgImageViewX = bgImageViewX + bgImageViewW;
		
		CGFloat newCardViewY = cropAreaViewY + cropAreaViewH;
		CGFloat newBgImageViewY = bgImageViewY + bgImageViewH;
		
		if (newCardViewX < newBgImageViewX) {
			
			x = newBgImageViewX - newCardViewX;
			width = cropAreaViewW;
		}else{
			
			x = 0;
			width = cropAreaViewW - (newCardViewX - newBgImageViewX);
		}
		
		if (newCardViewY < newBgImageViewY) {
			
			y = newBgImageViewY - newCardViewY;
			height = cropAreaViewH;
			
		}else{
			
			y = 0;
			height = cropAreaViewH - (newCardViewY - newBgImageViewY);
		}
		
		self.size = CGSizeMake(bgImageViewW, bgImageViewH);
	}
	
	return CGRectMake(x, y, width, height);
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
	[self setupCutImageView:image fromPhotoLib:YES];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - LGTextSearchControllerDelegate
- (void)selctedSearchModel:(LGSearchModel *)searchModel{
    self.searchController.active = NO;
    [self performSegueWithIdentifier:@"imageSearchToDetail" sender:searchModel];
}

#pragma mark -
-(void)dealloc{
    [self.cameraManager.session stopRunning];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"imageSearchToDetail"]) {
        LGSearchModel *searchModel = sender;
        LGWordDetailController *controller = segue.destinationViewController;
        controller.controllerType = LGWordDetailSearch;
        controller.searchWordStr = searchModel.word;
        controller.searchWordID = searchModel.ID;
    }
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
