//
//  LGNoStudyTypeController.m
//  Word
//
//  Created by Charles Cao on 2018/1/30.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGNoStudyTypeController.h"
#import "LGUserManager.h"

@interface LGNoStudyTypeController ()

@end

@implementation LGNoStudyTypeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
	[self setStudyType];
}


/**
 设置学习模式文字
 */
- (void)setStudyType{
	LGStudyType type = [LGUserManager shareManager].user.studyModel;
	NSString *str = @"";
	switch (type) {
		case LGStudyNone:
			str = @"你还未选择记忆模式";
			break;
		case LGStudyEbbinghaus:
			str = @"你正在使用艾宾浩斯记忆法(科学记忆)记忆单词";
			break;
		case LGStudyReview:
			str = @"你正在使用复习记忆法(快速巩固)记忆单词";
			break;
		case LGStudyOnlyNew:
			str = @"你正在使用只背新单词(快速记忆)记忆单词";
			break;
	}
	self.studyTypeLabel.text = str;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//进去单词库
- (IBAction)showWordLibraryAction:(id)sender {
	
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
