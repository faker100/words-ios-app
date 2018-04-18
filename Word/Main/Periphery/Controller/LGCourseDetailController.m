//
//  LGCourseDetailController.m
//  Word
//
//  Created by Charles Cao on 2018/4/9.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGCourseDetailController.h"
#import "LGWebController.h"
#import "NSString+LGString.h"



@interface LGCourseDetailController ()

@end

@implementation LGCourseDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[self configData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
	
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

- (void)configData{
	[self.imageView sd_setImageWithURL:[NSURL URLWithString:self.courseModel.image] placeholderImage:PLACEHOLDERIMAGE];
	self.nameLabel.text = self.courseModel.name;
	self.joinNumLabel.text = [NSString stringWithFormat:@"%@人已加入",self.courseModel.view];
	self.contentTextView.attributedText = [self.courseModel.content htmlToAttributeStringContent:@"" width:SCREEN_WIDTH];
}

//咨询
- (IBAction)adviceAction:(id)sender {
	LGWebController *web = [LGWebController contactAdvisorWebController];
	[self.navigationController pushViewController:web animated:YES];
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
