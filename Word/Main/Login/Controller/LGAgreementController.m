//
//  LGAgreementController.m
//  Word
//
//  Created by Charles Cao on 2018/5/7.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGAgreementController.h"
#import "LGNavigationController.h"

@interface LGAgreementController ()

@end

@implementation LGAgreementController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	[((LGNavigationController *)self.navigationController) transparenceBar:NO];
}

- (void)viewWillDisappear:(BOOL)animated{
	[super viewWillDisappear:animated];
	[((LGNavigationController *)self.navigationController) transparenceBar:YES];
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
