//
//  LGDictationController.m
//  Word
//
//  Created by Charles Cao on 2018/3/6.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGDictationController.h"
#import "LGDictationReviewModel.h"
#import "LGDictationPractiseController.h"

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
	[LGProgressHUD showHUDAddedTo:self.view];
	[self.request requestDicationIndexCompletion:^(id response, LGError *error) {
		if ([self isNormal:error]) {
			self.reviewModel = [LGDictationReviewModel mj_objectWithKeyValues:response];
		}
	}];
}

- (void)setReviewModel:(LGDictationReviewModel *)reviewModel {
	_reviewModel = reviewModel;
	self.allLabel.text         = [NSString stringWithFormat:@"( 共%@词 )",reviewModel.all];
	self.dimLabel.text    	   = [NSString stringWithFormat:@"( 共%@词 )",reviewModel.dim];
	self.incognizantLabel.text = [NSString stringWithFormat:@"( 共%@词 )",reviewModel.incognizant];
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
		
		[self requestDictationWordsWithStatus:LGWordStatusVague];
		
	}else if(view.tag == 101 && self.reviewModel.incognizant.integerValue > 0)
	{
		[self requestDictationWordsWithStatus:LGWordStatusIncognizance];
	
	}else if (view.tag == 102 && self.reviewModel.all.integerValue > 0)
	{
		[self requestDictationWordsWithStatus:LGWordStatusNone];
	}else{
		[LGProgressHUD showMessage:@"没有复习的单词" toView:self.view];
	}
}


/**
 请求某状态下的单词

 @param status 要复习的状态
 */
- (void)requestDictationWordsWithStatus:(LGWordStatus)status{
	[LGProgressHUD showHUDAddedTo:self.view];
	[self.request requestDictationWordsWithStatus:status completion:^(id response, LGError *error) {
		if ([self isNormal:error]) {
			NSMutableArray *wordIDArray = [NSMutableArray arrayWithArray:response];
			[self performSegueWithIdentifier:@"dictationIndexToPractise" sender:wordIDArray];
		}
	}];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	
	LGDictationPractiseController *controller = segue.destinationViewController;
	controller.wordIDArray = sender;
	
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
