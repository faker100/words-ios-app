//
//  LGReciteWordsController.m
//  Word
//
//  Created by Charles Cao on 2018/1/26.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGReciteWordsController.h"

@interface LGReciteWordsController ()

@end

@implementation LGReciteWordsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[self configNavigationBar];
}

- (void)configNavigationBar{
	
//	UIButton *header = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
//	header.layer.cornerRadius = 22;
//	
//	[header setImage:PLACEHOLDERIMAGE forState:UIControlStateNormal];
//	UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:header];
//	
//	self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//语音搜索
- (IBAction)speakSearchAction:(id)sender {
	NSLog(@"yuy");
}

//拍照搜索
- (IBAction)pictureSearch:(id)sender {
	NSLog(@"拍照");
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
