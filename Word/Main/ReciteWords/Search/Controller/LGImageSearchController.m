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

@end

@implementation LGImageSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.cameraManager = [LGCameraManager new];
    [self.cameraManager reload];
	[self.view.layer insertSublayer:self.cameraManager.previewLayer atIndex:0];
    [self touchZoneWithPoint:CGPointZero];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.cameraManager.openFlashLight = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 拖动裁剪区域

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
        
        NSLog(@"%@",NSStringFromCGPoint(point));
        
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

	[LGProgressHUD showHUDAddedTo:self.view];
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
		[LGBaiduOcrManager requestWithImage:cutImage complete:^(NSString *string) {
			[LGProgressHUD hideHUDForView:self.view];
			if (string.length > 0) {
				self.searchController = [[LGSearchController alloc]initWithText:string delegate:self];
				[self.navigationController presentViewController:self.searchController animated:YES completion:nil];
			}else{
				[LGProgressHUD showMessage:@"解析失败" toView:self.view];
			}
		}];
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

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    
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
