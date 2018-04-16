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

@interface LGImageSearchController ()

@property (nonatomic, strong) LGCameraManager *cameraManager;

@end

@implementation LGImageSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.cameraManager = [LGCameraManager new];
    [self.cameraManager reload];
	[self.view.layer insertSublayer:self.cameraManager.previewLayer atIndex:0];

}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




/**
 拖动裁剪区域
 

 */
- (IBAction)panCutViewAction:(UIPanGestureRecognizer *)sender {
	CGPoint locationPoint = [sender locationInView:sender.view];
	CGPoint point = [sender translationInView:sender.view];
	
	
	NSLog(@"%@",NSStringFromCGPoint(locationPoint));
	
//	NSLog(@"%@",NSStringFromCGPoint(point));
}

- (IBAction)photographAction:(id)sender {
	[self.cameraManager cutCameraImageDataComplete:^(NSData *imageData) {
		
		UIImage *image = [UIImage imageWithData:imageData];
		
		[LGBaiduOcrManager requestWithImage:image complete:^(NSString *string) {
			
		}];
	}];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
