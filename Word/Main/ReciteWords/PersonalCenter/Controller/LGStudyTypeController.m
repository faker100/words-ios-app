//
//  LGStudyTypeController.m
//  Word
//
//  Created by Charles Cao on 2018/1/26.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGStudyTypeController.h"
#import "LGUserManager.h"

@interface LGStudyTypeController ()

@property (nonatomic, assign) LGStudyType selectedType; //选中的学习模式,如果用户之前没有选择,默认艾宾浩斯记忆法
@property (nonatomic, strong) UIView *selectedTypeView;	//不是从引导页过来的,默认选择用户的模式,未登录时选择引导页所选的模式

@end

@implementation LGStudyTypeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	

	if (!self.isPresentFromGuide) {
		self.selectedType = [LGUserManager shareManager].user.studyModel;
	}
	
	if (![[LGUserManager shareManager] isLogin]) {
		self.selectedType = [LGUserManager shareManager].notLoggedStudyType;
	}
}

- (void)setSelectedType:(LGStudyType)selectedType{
	
	if (_selectedType != selectedType) {

		switch (selectedType) {
			case LGStudyEbbinghaus: self.selectedTypeView = self.ebbinghausView;  break;
			case LGStudyReview: 	self.selectedTypeView = self.reviewView; 	  break;
			case LGStudyOnlyNew: 	self.selectedTypeView = self.onlyNewView;     break;
			default:break;
		}
	_selectedType = selectedType;
	}
}

- (void)setSelectedTypeView:(UIView *)selectedTypeView{
	
	//已选择的
	UIImageView *oldChooseImageView = [_selectedTypeView viewWithTag:100];
	UIView *oldBorderView = [_selectedTypeView viewWithTag:101];
	oldChooseImageView.hidden = YES;
	[oldBorderView.layer setBorderColorFromUIColor:[UIColor lg_colorWithHexString:@"F3F3F4"]];
	
	//新选择的
	UIImageView *chooseImageView = [selectedTypeView viewWithTag:100];
	UIView *borderView = [selectedTypeView viewWithTag:101];
	chooseImageView.hidden = NO;
	[borderView.layer setBorderColorFromUIColor:[UIColor lg_colorWithType:LGColor_theme_Color]];
	
	_selectedTypeView = selectedTypeView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//选择学习模式
- (IBAction)chooseStudyModel:(UITapGestureRecognizer *)sender {
	
		if (sender.view == self.ebbinghausView)  self.selectedType = LGStudyEbbinghaus;
		if (sender.view == self.reviewView) 	 self.selectedType = LGStudyReview;
		if (sender.view == self.onlyNewView) 	 self.selectedType = LGStudyOnlyNew;
		if (self.isPresentFromGuide) {
			[LGUserManager shareManager].notLoggedStudyType = self.selectedType;
			[self dismissViewControllerAnimated:YES completion:nil];
		}
}


//提交学习模式
- (IBAction)updateStudyAction:(id)sender {
	
	if (self.selectedType == LGStudyNone) {
		[LGProgressHUD showMessage:@"请选择学习模式" toView: self.view];
		return;
	}
	
	if ([LGUserManager shareManager].user.studyModel == self.selectedType) {
		[LGProgressHUD showMessage:@"学习模式不能和以前一样" toView:self.view];
		return;
	}
	[LGProgressHUD showHUDAddedTo:self.view];
	[self.request updateStudyType:self.selectedType completion:^(id response, LGError *error) {
		if ([self isNormal:error]) {
			[LGProgressHUD showSuccess:@"修改成功" toView:self.view completionBlock:^{
				[LGUserManager shareManager].user.studyModel = self.selectedType;
				[self.navigationController popViewControllerAnimated:YES];
			}];
		}
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
