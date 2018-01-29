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

@property (nonatomic, assign) LGStudyType selectedType; //选中的学习模式,默认艾宾浩斯记忆法
@property (nonatomic, strong) UIButton *selectedBtn;	//选中的 button, 默认ebbinghausButton

@end

@implementation LGStudyTypeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.selectedType = LGStudyEbbinghaus;
	self.selectedBtn = self.ebbinghausButton;
}

- (void)setSelectedType:(LGStudyType)selectedType{
	
	if (_selectedType != selectedType) {
		self.selectedBtn.selected = NO;
		self.selectedBtn.backgroundColor = [UIColor lg_colorWithHexString:@"EAEAEA"];
	
		switch (selectedType) {
			case LGStudyEbbinghaus: self.selectedBtn = self.ebbinghausButton;  break;
			case LGStudyReview: 	self.selectedBtn = self.reviewButton; 	   break;
			case LGStudyOnlyNew: 	self.selectedBtn = self.onlyNewButton;     break;
		}
	_selectedType = selectedType;
	}
}

- (void)setSelectedBtn:(UIButton *)selectedBtn{
	selectedBtn.selected = YES;
	selectedBtn.backgroundColor = [UIColor lg_colorWithType:LGColor_theme_Color];
	_selectedBtn = selectedBtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//选择学习模式
- (IBAction)chooseStudyModel:(UIButton *)sender {
	if (sender.selected == NO) {
		if (sender == self.ebbinghausButton) self.selectedType = LGStudyEbbinghaus;
		if (sender == self.reviewButton) 	 self.selectedType = LGStudyReview;
		if (sender == self.onlyNewButton) 	 self.selectedType = LGStudyOnlyNew;
	}
}

//提交学习模式
- (IBAction)updateStudyAction:(id)sender {
	[LGProgressHUD showHUDAddedTo:self.view];
	[self.request updateStudyType:self.selectedType completion:^(id response, NSString *errorMessage) {
		[LGProgressHUD hideHUDForView:self.view];
		if (StringNotEmpty(errorMessage)) {
			[LGProgressHUD showError:errorMessage toView:self.view];
		}else{
			[[NSNotificationCenter defaultCenter] postNotificationName:ChangeTypeNotification object:nil userInfo:@{StudyTypeKey:self.selectedBtn.currentTitle}];
			[LGProgressHUD showSuccess:@"修改成功" toView:self.view completionBlock:^{
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
