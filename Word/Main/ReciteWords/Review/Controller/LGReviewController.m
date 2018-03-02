//
//  LGReviewController.m
//  Word
//
//  Created by Charles Cao on 2018/3/2.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGReviewController.h"
#import "LGReviewWrongListController.h"

@interface LGReviewController ()

@property (nonatomic, copy) NSString *totalNum;

@end

@implementation LGReviewController

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
	[self.request requestReviewIndexCompletion:^(id response, LGError *error) {
		if ([self isNormal:error]) {
			self.totalNum = [NSString stringWithFormat:@"%@",response[@"num"]];
		}
	}];
}

- (void)setTotalNum:(NSString *)totalNum{
	_totalNum = totalNum;
	self.wrongTotalLabel.text = [NSString stringWithFormat:@"  共%@词  ",totalNum];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	
	if ([segue.identifier isEqualToString:@"reviewIndexToWrongList"]) {
		LGReviewWrongListController *controller =  segue.destinationViewController;
		controller.totalNum = self.totalNum;
	}
	
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
