//
//  LGReciteWordsController.m
//  Word
//
//  Created by Charles Cao on 2018/1/26.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGReciteWordsController.h"
#import "LGStudyTypeController.h"
#import "LGUserManager.h"
#import "LGNoStudyTypeController.h"
#import "LGRecitePlanController.h"
#import <SDWebImage/UIButton+WebCache.h>
#import "LGTextSearchController.h"
#import "LGWordDetailController.h"
#import "LGTool.h"
#import "LGSearchController.h"
#import "LGVoiceSearchController.h"

@interface LGReciteWordsController () <LGTextSearchControllerDelegate>

@property (nonatomic, strong) LGUserModel *user;
@property (nonatomic, strong) LGNoStudyTypeController *noStudyTypeController;  //没有记忆计划
@property (nonatomic, strong) LGRecitePlanController *recitePlanController;     //有记忆计划

@property (nonatomic, weak) UIViewController *currentShowController; //当前显示的 view;

@property (nonatomic, strong) LGSearchController *searchController;

@end

@implementation LGReciteWordsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
	self.currentShowController = self.childViewControllers.lastObject;
	[self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		
		if ([obj isKindOfClass:[LGNoStudyTypeController class]]) {
			self.noStudyTypeController = obj;
		}else{
			self.recitePlanController = obj;
		}
	}];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess) name:LOGIN_NOTIFICATION object:nil];
	[self configLeftItem];
	[self configNavigationItem];
	
}

- (LGSearchController *)searchController{
    if (!_searchController) {
		
		_searchController = [[LGSearchController alloc]initWithText:@"" delegate:self];
    }
    return _searchController;
}

- (void)configNavigationItem{
    
    CGFloat width = 200.0/375.0f * SCREEN_WIDTH;
	self.titleViewWidthConstraint.constant = width;

    UIButton *titleBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, width, 30)];
    titleBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0);
    titleBtn.layer.cornerRadius = 4;
    titleBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [titleBtn setTitle:@"  搜索单词" forState:UIControlStateNormal];
    [titleBtn setImage:[UIImage imageNamed:@"search_icon"] forState:UIControlStateNormal];
    titleBtn.backgroundColor = [UIColor lg_colorWithHexString:@"20A870"];
    titleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    self.navigationItem.titleView = titleBtn;
    [titleBtn addTarget:self action:@selector(textSearchAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *voidceBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30,30)];
	
    [voidceBtn setImage:[UIImage imageNamed:@"microphone"] forState:UIControlStateNormal];
    [voidceBtn addTarget:self action:@selector(speakSearchAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *voiceItem = [[UIBarButtonItem alloc]initWithCustomView:voidceBtn];
    
    UIButton *picBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
	
    [picBtn setImage:[UIImage imageNamed:@"camera"] forState:UIControlStateNormal];
    [picBtn addTarget:self action:@selector(pictureSearch:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *picItem = [[UIBarButtonItem alloc]initWithCustomView:picBtn];
	
    self.navigationItem.rightBarButtonItems = @[voiceItem,picItem];
	
}

- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	if ([LGUserManager shareManager].isLogin) {
		[self configData];
	}
	
}

- (void)configLeftItem {
	UIView *tempView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 38, 38)];
	UIButton *itemButton = [[UIButton alloc]initWithFrame:tempView.bounds];
	[itemButton sd_setImageWithURL:[NSURL URLWithString:WORD_DOMAIN([LGUserManager shareManager].user.image])  forState:UIControlStateNormal placeholderImage:PLACEHOLDERIMAGE];
	 [itemButton addTarget:self action:@selector(pushUserInfo) forControlEvents:UIControlEventTouchUpInside];
	 itemButton.layer.cornerRadius = 19;
	 itemButton.layer.masksToBounds = YES;
	 [tempView addSubview:itemButton];
	 self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:tempView];
}

- (void)viewDidLayoutSubviews{
    [self showController:NO];
}

- (void)configData{
	__weak typeof(self) weakSelf = self;
	[self.request requestUserInfo:^(id response, LGError *error) {
		if ([self isNormal:error]){
			[LGUserManager shareManager].user = [LGUserModel mj_objectWithKeyValues:response[@"data"]];
			[self configLeftItem];
			[weakSelf showController:YES];
		}
	}];
}


/**
 转换 childController;
 有计划和记忆模式显示 LGRecitePlanController,
 没有计划和记忆模式显示 LGNoStudyTypeController
 如果 toController 为当前显示 controller 则不转换;
 
 @param animated 是否动画
 */
- (void)showController:(BOOL)animated {
	
	NSTimeInterval duration = animated ? 0.5 : 0;
	 LGUserModel *user = [LGUserManager shareManager].user;
	
	if (StringNotEmpty(user.planWords) && user.studyModel != LGStudyNone) {
		if (self.currentShowController == self.recitePlanController) return;
		self.currentShowController = self.recitePlanController;
		[self transitionFromViewController:self.noStudyTypeController toViewController:self.recitePlanController duration:duration options:UIViewAnimationOptionTransitionFlipFromLeft animations:nil completion:nil];
	}else{
		if (self.currentShowController == self.noStudyTypeController) return;
		self.currentShowController = self.noStudyTypeController;
		[self transitionFromViewController:self.recitePlanController toViewController:self.noStudyTypeController duration:duration options:UIViewAnimationOptionTransitionFlipFromLeft animations:nil completion:nil];
	}
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//文字搜索
- (void)textSearchAction{
    
    [self.navigationController.tabBarController presentViewController:self.searchController animated:YES completion:nil];
}
     
//语音搜索
- (void)speakSearchAction:(id)sender {
	BOOL flag = [LGTool checkDevicePermissions:LGDeviceMicrophone];
	if (flag){
		UINavigationController *voiceSearchNav = STORYBOARD_VIEWCONTROLLER(@"ReciteWords", @"LGVoiceSearchNavigation");
		self.navigationController.tabBarController.modalPresentationStyle = UIModalPresentationCurrentContext;
		[self.navigationController.tabBarController presentViewController:voiceSearchNav animated:YES completion:nil];
		
	}
}

//拍照搜索
- (void)pictureSearch:(id)sender {
    BOOL flag = [LGTool checkDevicePermissions:LGDeviceCamera];
    if(flag){
        [self performSegueWithIdentifier:@"indexToPhotoSearch" sender:nil];
    }
}
	 
- (void)pushUserInfo{
	[self performSegueWithIdentifier:@"IndexToUserCenter" sender:nil];
}
	 

//登录成功
- (void)loginSuccess{
	
	[self configData];
}

#pragma mark - LGTextSearchControllerDelegate
- (void)selctedSearchModel:(LGSearchModel *)searchModel{
    self.searchController.active = NO;
    [self performSegueWithIdentifier:@"searchToWordDetail" sender:searchModel];
}
     

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier isEqualToString:@"searchToWordDetail"]){
        LGSearchModel *searchModel = sender;
        LGWordDetailController *controller = segue.destinationViewController;
        controller.controllerType = LGWordDetailSearch;
        controller.searchWordID = searchModel.ID;
        controller.searchWordStr = searchModel.word;
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end

