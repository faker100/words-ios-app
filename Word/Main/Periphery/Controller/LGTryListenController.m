//
//  LGTryListenController.m
//  Word
//
//  Created by Charles Cao on 2018/4/11.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGTryListenController.h"
#import <VodSDK/VodSDK.h>
#import "AppDelegate.h"
#import "LGNavigationController.h"

@interface LGTryListenController () <VodDownLoadDelegate, VodPlayDelegate,GSVodDocViewDelegate>
{
	BOOL  isVideoFinished; //是否播放结束
	CGFloat startPosition; //开始播放进度
}
@property (nonatomic, strong) downItem *item;
@property (nonatomic, strong) VodDownLoader *voddownloader;
@property (nonatomic, strong) VodPlayer *vodplayer;

@end

@implementation LGTryListenController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[self configDownloader];
}

- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	[((LGNavigationController *)self.navigationController) transparenceBar:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
	[super viewWillAppear:animated];
	[((LGNavigationController *)self.navigationController) transparenceBar:NO];
	if (self.vodplayer) {
		[self.vodplayer stop];
		[self.vodplayer.docSwfView  clearVodLastPageAndAnno];//退出前清理一下文档模块
		self.vodplayer.docSwfView=nil;
		self.vodplayer = nil;
		self.item = nil;
	}
}

- (void)configDownloader{
	
	[LGProgressHUD showHUDAddedTo:self.playerView];
	self.voddownloader = [[VodDownLoader alloc]init];
	VodParam *param = [[VodParam alloc]init];
	param.domain = @"bjsy.gensee.com";
	param.vodID = @"K4wTImcBxP";
	param.number = @"";
	param.vodPassword = @"";
	param.nickName = @"小王";
	param.downFlag = 0;
	param.serviceType = @"training";
	
	self.voddownloader.delegate = self;
	self.voddownloader.vodTimeFlag = YES;
	[self.voddownloader addItem:param];
}

- (void)configPlayerVoditem:(downItem *)item{
	 if (item) {
		 self.item = item;
		CGRect videoViewRect = self.videoView.bounds;
		CGRect docViewRect = self.docView.bounds;
		 
		 if (self.vodplayer) {
			 [self.vodplayer stop];
			 self.vodplayer = nil;
		 }
		 //            self.vodplayer = [[VodPlayer alloc] initPlay:self videoViewFrame:videoViewRect docViewFrame:docViewRect downitem:Litem playDelegate:self];
		 self.vodplayer = ((AppDelegate*)[UIApplication sharedApplication].delegate).vodplayer;
		 if (!self.vodplayer) {
			 self.vodplayer = [[VodPlayer alloc]init];
		 }
		 
		 self.vodplayer.playItem = item;
		 self.vodplayer.mVideoView = [[VodGLView alloc]initWithFrame:videoViewRect];
		
		 [self.videoView addSubview:self.vodplayer.mVideoView];
		 
		 
		 self.vodplayer.docSwfView = [[GSVodDocView alloc]initWithFrame:docViewRect];
		 [self.docView addSubview:self.vodplayer.docSwfView];
		 if (@available(iOS 11.0, *)) {
			 self.vodplayer.docSwfView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
		 } else {
			 // Fallback on earlier versions
		 }
		 self.vodplayer.delegate = self;
		 self.vodplayer.docSwfView.vodDocDelegate=self;
		 self.vodplayer.docSwfView.gSDocModeType = VodScaleAspectFit;
		self.vodplayer.docSwfView.backgroundColor = [UIColor blackColor];  //文档没有显示出来之前，GSVodDocView显示的背景色
		 [self.vodplayer.docSwfView setGlkBackgroundColor:51 green:51 blue:51];//文档加载以后，侧边显示的颜色
		 
		 
		 [self.vodplayer OnlinePlay:YES audioOnly:NO];
		 
		 [self.vodplayer getChatListWithPageIndex:1];
	 }

}

//播放 / 暂停
- (IBAction)playAction:(UIButton *)sender {
	
	if (self.vodplayer) {
		if (sender.selected) {
			[self.vodplayer pause];
		}else{
			//如果已播放完成,重播
			if (isVideoFinished) {
				startPosition = 0;
				[self.vodplayer OnlinePlay:NO audioOnly:NO];
			}else{
				[self.vodplayer resume];
			}
		}
	sender.selected = !sender.selected;
	}
}

-(NSString *)formatTime:(int)msec {
	int hours = msec / 1000 / 60 / 60;
	int minutes = (msec / 1000 / 60) % 60;
	int seconds = (msec / 1000) % 60;
	
	return [NSString stringWithFormat:@"%02d:%02d:%02d", hours, minutes, seconds];
}


/**
 全屏

 */
- (IBAction)fullScreenAction:(UIButton *)sender {
	self.traitCollection 
}

//滑块拖动中
- (IBAction)valueChangeAction:(UISlider *)sender {
	
	self.currentTimeLabel.text = [self formatTime:sender.value];
}

//滑块拖动结束
- (IBAction)seekAction:(UISlider *)sender {
	if (isVideoFinished) {
		startPosition = sender.value;
		[self.vodplayer OnlinePlay:NO audioOnly:NO];
		
	}else{
		[self.vodplayer seekTo:sender.value];
	}
}


/**
 关闭打开视频
 selectred = yes 关闭

 */
- (IBAction)showVideoAction:(UIButton *)sender {
	sender.selected = !sender.selected;
	[self.vodplayer closeVideo:sender.selected];
}

#pragma mark - VodPlayDelegate
/**
 * 进度通知
 * @param position 当前播放进度
 */
- (void) onPosition:(int) position{
	self.currentTimeLabel.text = [self formatTime:position];
	self.playButton.selected = YES;
	[self.slider setValue:position];
	//[LGProgressHUD hideHUDForView:self.playerView];
}

/**
 * 缓存通知
 * @param bBeginBuffer ture: 缓开始  false:缓存结束
 */
- (void) OnBuffer:(BOOL)bBeginBuffer{
	NSLog(@"%d",bBeginBuffer);
	if (bBeginBuffer) {
		[LGProgressHUD showHUDAddedTo:self.playerView];
	}else{
		[LGProgressHUD hideHUDForView:self.playerView];
	}
}

/*
 *监听video 的开始
 */
- (void)onVideoStart{
	[LGProgressHUD hideHUDForView:self.playerView];
}

#pragma mark - VodDownLoadDelegate
//添加item的回调方法
- (void)onAddItemResult:(RESULT_TYPE)resultType voditem:(downItem *)item {
	if (resultType == RESULT_SUCCESS) {
		
		[self configPlayerVoditem:item];
		
	}else if (resultType == RESULT_ROOM_NUMBER_UNEXIST){
		UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"点播间不存在"  delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
		[alertView show];
	}else if (resultType == RESULT_FAILED_NET_REQUIRED){
		UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"网络请求失败"  delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
		[alertView show];
	}else if (resultType == RESULT_FAIL_LOGIN){
		UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"用户名或密码错误"  delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
		[alertView show];
	}else if (resultType == RESULT_NOT_EXSITE){
		UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"该点播的编号的点播不存在"  delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
		[alertView show];
	}else if (resultType == RESULT_INVALID_ADDRESS){
		UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"无效地址" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
		[alertView show];
	}else if (resultType == RESULT_UNSURPORT_MOBILE){
		UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"不支持移动设备"  delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
		[alertView show];
	}else if (resultType == RESULT_FAIL_TOKEN){
		UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"口令错误"  delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
		[alertView show];
	}
}

//初始化VodPlayer代理
- (void)onInit:(int)result haveVideo:(BOOL)haveVideo duration:(int)duration docInfos:(NSDictionary *)docInfos
{
	
	//    [self.vodplayer getChatAndQalistAction];
	self.totalTimeLabel.text = [self formatTime:duration];
	self.slider.maximumValue = duration;
	isVideoFinished = NO;
	[self.vodplayer seekTo:startPosition];
	
}

/**
 * 播放完成停止通知，
 */
- (void) onStop{
	isVideoFinished = YES;
	self.playButton.selected = NO;
}

#pragma mark - 横竖屏
- (BOOL)shouldAutorotate {
	return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
	return UIInterfaceOrientationMaskPortrait;
}

//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
//	return [self.selectedViewController preferredInterfaceOrientationForPresentation];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end



