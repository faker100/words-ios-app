//
//  LGDiscoverDetailController.m
//  Word
//
//  Created by Charles Cao on 2018/4/4.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGDiscoverDetailController.h"

@interface LGDiscoverDetailController ()

@end

@implementation LGDiscoverDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[self configData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configData{
	self.discoverNameLabel.text = self.discoverModel.name;
	self.discoverTitleLabel.text = self.discoverModel.title;
	[self.discoverImageView sd_setImageWithURL:[NSURL URLWithString:WORD_DOMAIN(self.discoverModel.image)]];
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
