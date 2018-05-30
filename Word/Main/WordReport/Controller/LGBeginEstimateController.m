//
//  LGBeginEstimateController.m
//  Word
//
//  Created by caoguochi on 2018/4/1.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGBeginEstimateController.h"
#import "LGUserManager.h"

@interface LGBeginEstimateController ()

@end

@implementation LGBeginEstimateController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    LGUserModel *user = [LGUserManager shareManager].user;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:WORD_DOMAIN(user.image)] placeholderImage:PLACEHOLDERIMAGE];
    self.usernameLabel.text = user.nickname;
    NSInteger estimateNum = user.estimateWords.integerValue;
	self.vocabularyLabel.text = estimateNum == 0 ? @"未评估" : @(estimateNum).stringValue;
	self.estimateResultButton.hidden = estimateNum == 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 开始评估

 */
- (IBAction)beginEstimateAction:(id)sender {
	[LGProgressHUD showHUDAddedTo:self.view];
	[self.request requestBeginEstimateCompletion:^(id response, LGError *error) {
		if ([self isNormal:error]) {
			NSString *code = response[@"code"];
			if (code.integerValue == 1) {
				[self performSegueWithIdentifier:@"beginEstimateToEstimate" sender:nil];
			}
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
