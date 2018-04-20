//
//  LGPublicDetailController.m
//  Word
//
//  Created by Charles Cao on 2018/4/9.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGPublicDetailController.h"
#import "LGWebController.h"
#import "NSString+LGString.h"

@interface LGPublicDetailController ()

@end

@implementation LGPublicDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[self configData];
}

- (void)configData{
	[self.imageView sd_setImageWithURL:[NSURL URLWithString:OPPEN_DOMAIN(self.classModel.image)] placeholderImage:PLACEHOLDERIMAGE];
	self.nameLabel.text = self.classModel.title;
	self.joinLabel.text = [NSString stringWithFormat:@"%@人已加入",self.classModel.viewCount];
	[self.classModel.courseDescriptionHTML htmlToAttributeStringContent:OPPEN_DOMAIN(@"") width:SCREEN_WIDTH completion:^(NSMutableAttributedString *attrStr) {
		self.contentTextView.attributedText = attrStr;
	}];
//	self.contentTextView.attributedText = [self.classModel.courseDescriptionHTML htmlToAttributeStringContent:OPPEN_DOMAIN(@"") width:SCREEN_WIDTH];
}

- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	[self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
	self.navigationController.navigationBar.shadowImage = [UIImage new];
}

- (void)viewWillDisappear:(BOOL)animated{
	[super viewWillDisappear:animated];
	[self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
	self.navigationController.navigationBar.shadowImage = nil;
}

- (IBAction)adviceAction:(id)sender {
	LGWebController *web = [LGWebController contactAdvisorWebController];
	[self.navigationController pushViewController:web animated:YES];
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
