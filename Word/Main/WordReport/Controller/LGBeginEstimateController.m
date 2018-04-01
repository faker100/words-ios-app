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
    [self requestData];
    
    [self.request reqeustEstimateWordsCompletion:^(id response, LGError *error) {
        if ([self isNormal:error]) {
            NSLog(@"%@",response);
        }
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)requestData{
    
    [self.request requestBeginEstimateCompletion:^(id response, LGError *error) {
        if ([self isNormal:error]) {
            NSLog(@"%@",response);
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
