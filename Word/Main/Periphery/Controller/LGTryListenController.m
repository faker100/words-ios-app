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
#import "LGTool.h"

@interface LGTryListenController () <VodDownLoadDelegate, VodPlayDelegate,GSVodDocViewDelegate>
{
	BOOL isVideoFinished; //是否播放结束
	BOOL islandscape; //是否横屏
	
	CGFloat startPosition; //开始播放进度
	NSArray <NSString *> *speedArray;
	dispatch_source_t timer;
	
}
@property (nonatomic, strong) downItem *item;
@property (nonatomic, strong) VodDownLoader *voddownloader;
@property (nonatomic, strong) VodPlayer *vodplayer;
@property (nonatomic, assign) BOOL showTool; //是否显示工具栏

@end

@implementation LGTryListenController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[self configData];
}

- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	//隐藏导航栏
	[self.navigationController.view sendSubviewToBack:self.navigationController.navigationBar];
}

- (void)viewDidAppear:(BOOL)animated{
	[super viewDidAppear:animated];
	[self beginCountDownForHiddenTool];
}

- (void)viewWillDisappear:(BOOL)animated{
	[super viewWillAppear:animated];
	//显示导航栏
	[self.navigationController.view bringSubviewToFront:self.navigationController.navigationBar];
	AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
	appDelegate.allowRotation = NO; // 关闭横屏
	
	if (self.vodplayer) {
		[self.vodplayer stop];
		[self.vodplayer.docSwfView  clearVodLastPageAndAnno];//退出前清理一下文档模块
		self.vodplayer.docSwfView=nil;
		self.vodplayer = nil;
		self.item = nil;
	}
}

- (void)setShowTool:(BOOL)showTool{
	_showTool = showTool;
	if (showTool) {
		self.topLayoutConstraint.constant = -64;
		self.bottomLayoutConstraint.constant = 35;
	}else{
		self.topLayoutConstraint.constant = 0;
		self.bottomLayoutConstraint.constant = 0;
	}
	[UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
		
		[self.playerView layoutIfNeeded];
		
	} completion:^(BOOL finished) {
		
	}];
}

- (void)configData{
	speedArray = @[@"1.0x", @"1.2x", @"1.5x", @"2.0x"];
	[self.speedButton setTitle:speedArray.firstObject forState:UIControlStateNormal];
	self.showTool = YES;
	[self.slider setThumbImage:[UIImage imageNamed:@"play_slider"] forState:UIControlStateNormal];
	[self configDownloader:self.courseModel.url];
	self.courseTitleLabel.text = self.courseModel.name;
    __weak typeof(self) weakSelf = self;
    [self.courseModel.content htmlToAttributeStringContent:@"" width:SCREEN_WIDTH completion:^(NSMutableAttributedString *attrStr) {
        weakSelf.contentTextView.attributedText = attrStr;
        
        [weakSelf.activityView stopAnimating];
    }];
}

- (void)configDownloader:(NSString *)vodID{
	
	[LGProgressHUD showHUDAddedTo:self.docView];
	self.voddownloader = [[VodDownLoader alloc]init];
	VodParam *param = [[VodParam alloc]init];
	param.domain = @"bjsy.gensee.com";
	param.vodID = vodID;
	param.number = @"";
	param.vodPassword = @"";
	param.downFlag = 0;
	param.serviceType = @"training";
	self.voddownloader.delegate = self;
	self.voddownloader.vodTimeFlag = YES;
	[self.voddownloader addItem:param];
}


- (void)configPlayerVoditem:(downItem *)item{
	 if (item) {
		 
		 self.item = item;
		 if (self.vodplayer) {
			 [self.vodplayer stop];
			 self.vodplayer = nil;
		 }
		 
		 self.vodplayer = ((AppDelegate*)[UIApplication sharedApplication].delegate).vodplayer;
		 if (!self.vodplayer) {
			 self.vodplayer = [[VodPlayer alloc]init];
		 }
		 
		 self.vodplayer.playItem = item;
		 self.vodplayer.mVideoView = [[VodGLView alloc]initWithFrame:self.videoView.bounds];
		
		 [self.videoView addSubview:self.vodplayer.mVideoView];
		 
		 
		 self.vodplayer.docSwfView = [[GSVodDocView alloc]initWithFrame:self.docView.bounds];
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


/**
 开始倒计时 隐藏 工具条
 */
- (void)beginCountDownForHiddenTool{
	[LGTool cancelTimer:timer];
	timer = [LGTool beginCountDownWithSecond:3 completion:^(NSInteger currtentSecond) {
		if (currtentSecond == 0) {
			self.showTool = NO;
		}
	}];
}

- (IBAction)tapPlayViewAction:(id)sender {
	self.showTool = !self.showTool;
	[self beginCountDownForHiddenTool];
}


- (IBAction)speedAction:(UIButton *)sender {
	
	[self beginCountDownForHiddenTool];
	
	NSString *currentTitle = sender.currentTitle;
	__block NSInteger nextSpeedIndex;
	[speedArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		if ([obj isEqualToString:currentTitle]) {
			nextSpeedIndex = idx == speedArray.count - 1 ? 0 : idx + 1;
		};
	}];
	[sender setTitle:speedArray[nextSpeedIndex] forState:UIControlStateNormal];
	
	SpeedValue speedValue = SPEED_NORMAL;
	if (nextSpeedIndex == 1) speedValue = SPEED_125;
	if (nextSpeedIndex == 2) speedValue = SPEED_150;
	if (nextSpeedIndex == 3) speedValue = SPEED_2;

	[self.vodplayer SpeedPlay:speedValue];
}

/**
 竖屏时pop, 横盘时返回竖屏状态

 */
- (IBAction)backAction:(UIButton *)sender {
	
	if (islandscape) {
		[self setNewOrientation:NO];
	}else{
		[self.navigationController popViewControllerAnimated:YES];
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

	[self setNewOrientation:!islandscape];//调用转屏代码
}

//滑块拖动中
- (IBAction)valueChangeAction:(UISlider *)sender {
	[LGTool cancelTimer:timer];
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
	[self beginCountDownForHiddenTool];
}


/**
 关闭打开视频
 selectred = yes 关闭

 */
- (IBAction)showVideoAction:(UIButton *)sender {
	sender.selected = !sender.selected;
	self.videoView.hidden = sender.selected;
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
}

/**
 * 缓存通知
 * @param bBeginBuffer ture: 缓开始  false:缓存结束
 */
- (void) OnBuffer:(BOOL)bBeginBuffer{
	NSLog(@"%d",bBeginBuffer);
	if (bBeginBuffer) {
		[LGProgressHUD showHUDAddedTo:self.docView];
	}else{
		[LGProgressHUD hideHUDForView:self.docView];
	}
}

/*
 *监听video 的开始
 */
- (void)onVideoStart{
	[LGProgressHUD hideHUDForView:self.docView];
}

#pragma mark - VodDownLoadDelegate
//添加item的回调方法
- (void)onAddItemResult:(RESULT_TYPE)resultType voditem:(downItem *)item {
	
	NSString *alertStr = @"";
	
	if (resultType != RESULT_SUCCESS) {
		[LGProgressHUD hideHUDForView:self.docView];
	}
	
	if (resultType == RESULT_SUCCESS) {
		
		[self configPlayerVoditem:item];
		
	}else if (resultType == RESULT_ROOM_NUMBER_UNEXIST){
		alertStr = @"点播间不存在";
	}else if (resultType == RESULT_FAILED_NET_REQUIRED){
		alertStr = @"网络请求失败";
	}else if (resultType == RESULT_FAIL_LOGIN){
		alertStr = @"用户名或密码错误";
	}else if (resultType == RESULT_NOT_EXSITE){
		alertStr = @"该点播的编号的点播不存在";
	}else if (resultType == RESULT_INVALID_ADDRESS){
		alertStr = @"无效地址";
	}else if (resultType == RESULT_UNSURPORT_MOBILE){
		alertStr =  @"不支持移动设备";
	}else if (resultType == RESULT_FAIL_TOKEN){
		alertStr =  @"口令错误";
	}
	if (alertStr.length > 0) {
		[LGProgressHUD showError:alertStr toView:self.view];
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

/**
 是否全屏

 @param fullscreen YES - NO
 */
- (void)setNewOrientation:(BOOL)fullscreen
{
	islandscape = fullscreen;
	
	self.courseTitleLabel.hidden = !fullscreen;
	self.speedButton.hidden = !fullscreen;
	self.showVideoButton.hidden = !fullscreen;
	if (fullscreen){
		self.topToolView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.29];
	}else{
		self.topToolView.backgroundColor = [UIColor clearColor];
	}
	AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
	appDelegate.allowRotation = fullscreen;//打开 / 关闭横屏
	if (fullscreen) {
		NSNumber *resetOrientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
		[[UIDevice currentDevice] setValue:resetOrientationTarget forKey:@"orientation"];
		NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft];
		[[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
	}else{
		NSNumber *resetOrientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
		[[UIDevice currentDevice] setValue:resetOrientationTarget forKey:@"orientation"];
		NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
		[[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
	}
	
	self.vodplayer.docSwfView.frame = self.docView.bounds;
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



