//
//  LGCaseDetailController.m
//  Word
//
//  Created by Charles Cao on 2018/4/9.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGCaseDetailController.h"
#import "LGNavigationController.h"
#import "NSDate+Utilities.h"

@interface LGCaseDetailController ()

@end

@implementation LGCaseDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[self.headImageView sd_setImageWithURL:[NSURL URLWithString:self.caseModel.image] placeholderImage:PLACEHOLDERIMAGE];
	self.nameLabel.text = self.caseModel.name;
	self.contentTextView.text = self.caseModel.content;
	self.timeLabel.text = [[NSDate defaultDateFormatter] stringFromDate:[NSDate dateWithTimeIntervalSince1970:self.caseModel.createTime]];
	__weak typeof(self) weakSelf = self;
	[self.caseModel.details htmlToAttributeStringContent:@"" width:SCREEN_WIDTH - 40 completion:^(NSMutableAttributedString *attrStr) {
		weakSelf.contentTextView.text = @"";
		weakSelf.contentTextView.attributedText = attrStr;
	}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
