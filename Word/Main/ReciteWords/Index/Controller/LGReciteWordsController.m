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

@interface LGReciteWordsController ()

@property (nonatomic, strong) LGUserModel *user;
@property (nonatomic, strong) LGNoStudyTypeController *noStudyTypeController;  //没有记忆计划
@property (nonatomic, strong) LGRecitePlanController *recitePlanController;     //有记忆计划

@property (nonatomic, weak) UIViewController *currentShowController; //当前显示的 view;

@end

@implementation LGReciteWordsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	//[self configNavigationBar];
	
	self.currentShowController = self.childViewControllers.lastObject;
	[self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		
		if ([obj isKindOfClass:[LGNoStudyTypeController class]]) {
			self.noStudyTypeController = obj;
		}else{
			self.recitePlanController = obj;
		}
	}];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess) name:LOGIN_NOTIFICATION object:nil];
	[self setLeftItem];
	[self configNavigationItem];
	
}

- (void)configNavigationItem{
	self.titleViewWidthConstraint.constant = 200.0/375.0f * SCREEN_WIDTH;
	NSArray <UIBarButtonItem *> *rightItemArray = self.navigationItem.rightBarButtonItems;
	[rightItemArray.lastObject setImageInsets:UIEdgeInsetsMake(0, 15, 0, -15)];
	
}

- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	[self configData];
}

- (void)setLeftItem {
	UIView *tempView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 37, 37)];
	UIButton *itemButton = [[UIButton alloc]initWithFrame:tempView.bounds];
	[itemButton sd_setImageWithURL:[NSURL URLWithString:WORD_DOMAIN([LGUserManager shareManager].user.image])  forState:UIControlStateNormal placeholderImage:PLACEHOLDERIMAGE];
	 [itemButton addTarget:self action:@selector(pushUserInfo) forControlEvents:UIControlEventTouchUpInside];
	 itemButton.layer.cornerRadius = 20;
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
			[self setLeftItem];
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

- (void)configNavigationBar{
	
	UIButton *header = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
	header.layer.cornerRadius = 22;
	header.layer.masksToBounds = YES;
	[header setImage:PLACEHOLDERIMAGE forState:UIControlStateNormal];
	UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:header];
	self.navigationItem.leftBarButtonItem = leftItem;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//语音搜索
- (IBAction)speakSearchAction:(id)sender {
	NSLog(@"yuy");
//	[self transitionFromViewController:self.recitePlanController toViewController:self.noStudyTypeController duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft animations:nil completion:nil];
}

//拍照搜索
- (IBAction)pictureSearch:(id)sender {
	NSLog(@"拍照");
	
	[self.request requestSearchWordWithStr:@"A" completion:^(id response, LGError *error) {
		if([self isNormal:error]){
			NSLog(@"%@",response);
		}
	}];
	
//	[self transitionFromViewController:self.noStudyTypeController toViewController:self.recitePlanController duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft animations:nil completion:nil];
}
	 
- (void)pushUserInfo{
	[self performSegueWithIdentifier:@"IndexToUserCenter" sender:nil];
}
	 

//登录成功
- (void)loginSuccess{
	
	[self configData];
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
