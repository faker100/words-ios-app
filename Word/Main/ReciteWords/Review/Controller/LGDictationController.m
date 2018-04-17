//
//  LGDictationController.m
//  Word
//
//  Created by Charles Cao on 2018/3/6.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGDictationController.h"
#import "LGDictationReviewModel.h"
#import "LGDictationGroupController.h"

@interface LGDictationController ()

@property (nonatomic, strong) LGDictationReviewModel*reviewModel;

@end

@implementation LGDictationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	[self requestData];
}

- (void)requestData{
	[self.request requestDicationIndexCompletion:^(id response, LGError *error) {
		if ([self isNormal:error]) {
			self.reviewModel = [LGDictationReviewModel mj_objectWithKeyValues:response];
		}
	}];
}

- (void)setReviewModel:(LGDictationReviewModel *)reviewModel {
	_reviewModel = reviewModel;
	self.allLabel.text         = [NSString stringWithFormat:@"( 共%ld词 )",reviewModel.all.integerValue];
	self.dimLabel.text    	   = [NSString stringWithFormat:@"( 共%ld词 )",reviewModel.dim.integerValue];
	self.incognizantLabel.text = [NSString stringWithFormat:@"( 共%ld词 )",reviewModel.incognizant.integerValue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 选择复习内容  dictationIndexToPractise
 tag-100 模糊词组, tag-101 不认识, tag-102 全部词组
 */
- (IBAction)chooseReviewStatus:(UITapGestureRecognizer *)sender {
	UIView *view = sender.view;
	
	if (view.tag == 100 && self.reviewModel.dim.integerValue > 0) {
		[self performSegueWithIdentifier:@"dictationIndexToGroup" sender:@(LGWordStatusVague)];
	}else if(view.tag == 101 && self.reviewModel.incognizant.integerValue > 0){

		[self performSegueWithIdentifier:@"dictationIndexToGroup" sender:@(LGWordStatusIncognizance)];
	}else if (view.tag == 102 && self.reviewModel.all.integerValue > 0){
		[self performSegueWithIdentifier:@"dictationIndexToGroup" sender:@(LGWordStatusNone)];
	}else{
		[LGProgressHUD showMessage:@"没有复习的单词" toView:self.view];
	}
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	
	if ([segue.identifier isEqualToString:@"dictationIndexToGroup"]) {
		LGDictationGroupController *controller = segue.destinationViewController;
		NSInteger status = ((NSNumber *)sender).integerValue;
		controller.status = status;
		
		if (status == LGWordStatusVague){
			controller.title = @"模糊词组";
			controller.totalNum = self.reviewModel.dim;
		}else if (status == LGWordStatusIncognizance){
			controller.title = @"不认识词组";
			controller.totalNum = self.reviewModel.incognizant;
		}else{
			controller.title = @"全部词组";
			controller.totalNum = self.reviewModel.all;
		}
	}
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
