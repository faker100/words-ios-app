//
//  LGPKDiscoverController.m
//  Word
//
//  Created by caoguochi on 2018/4/3.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGPKDiscoverController.h"

@interface LGPKDiscoverController ()

@end

@implementation LGPKDiscoverController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requestData{
    [self.request requestPKDiscover:@"1" Completion:^(id response, LGError *error) {
        
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
