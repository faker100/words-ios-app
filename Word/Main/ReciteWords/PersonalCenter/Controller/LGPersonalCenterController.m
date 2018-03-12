//
//  LGPersonalCenterController.m
//  Word
//
//  Created by Charles Cao on 2018/3/12.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGPersonalCenterController.h"

@interface LGPersonalCenterController ()

@end

@implementation LGPersonalCenterController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//跳转个人资料
- (IBAction)pushToUserInfo:(id)sender {
	[self performSegueWithIdentifier:@"personalCenterToPersonInfo" sender:nil];
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
