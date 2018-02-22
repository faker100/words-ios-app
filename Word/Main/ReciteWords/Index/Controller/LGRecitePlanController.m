//
//  LGRecitePlanController.m
//  Word
//
//  Created by Charles Cao on 2018/2/6.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGRecitePlanController.h"
#import "LGReciteWordModel.h"
#import "LGUserManager.h"

@interface LGRecitePlanController ()

@end

@implementation LGRecitePlanController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [self configData];
}

- (void)configData{
    __weak typeof(self) weakSelf = self;
    [self.request requestIndexRecitePlan:^(id response, LGError *error) {
        if ([weakSelf isNormal:error showInView:self.parentViewController.view]) {
			LGReciteWordModel *model = [LGReciteWordModel mj_objectWithKeyValues:response];
			[weakSelf configInterface:model];
        }
    }];
}

/**
 打卡
 */
- (IBAction)clockAction:(UIButton *)sender {
	
}


/**
 开始背单词
 */
- (IBAction)beginReciteWordsAction:(id)sender {
	[self performSegueWithIdentifier:@"indexPlanToBeginReciteWords" sender:nil];
}


/**
 复习
 */
- (IBAction)reviewAction:(id)sender {
}

/**
 通过 LGReciteWordModel 更新界面
 */
- (void)configInterface:(LGReciteWordModel *) model{
	
	//坚持天数
	self.insistLabel.text = [NSString stringWithFormat:@"  已坚持%@天",model.insistDay];
	
	//剩余天数
	NSString *surplusDayStr = [NSString stringWithFormat:@"剩余\n%@天",model.surplusDay];
	NSMutableAttributedString *surplusDayAttributeStr = [[NSMutableAttributedString alloc]initWithString:surplusDayStr];
	[surplusDayAttributeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, surplusDayAttributeStr.length)];
	[surplusDayAttributeStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, surplusDayAttributeStr.length)];
	[surplusDayAttributeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(surplusDayAttributeStr.length-1-model.surplusDay.length, model.surplusDay.length)];
	[surplusDayAttributeStr addAttribute:NSForegroundColorAttributeName value:[UIColor lg_colorWithType:LGColor_Dark_Yellow] range:NSMakeRange(surplusDayAttributeStr.length-1-model.surplusDay.length, model.surplusDay.length)];
	self.surplusLabel.attributedText = surplusDayAttributeStr;
	
	//今天需背单词
	NSString *todayWordStr = [NSString stringWithFormat:@"%@个",model.userPackage.planWords];
	NSMutableAttributedString *todayWordAttributeStr = [[NSMutableAttributedString alloc]initWithString:todayWordStr];
	[todayWordAttributeStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, model.userPackage.planWords.length)];
	[todayWordAttributeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:24] range:NSMakeRange(0, model.userPackage.planWords.length)];
	[todayWordAttributeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(todayWordAttributeStr.length - 1, 1)];
	self.todayWordLabel.attributedText = todayWordAttributeStr;
	
	//累计已背单词
	NSString *totalWordStr = [NSString stringWithFormat:@"%@个",model.userAllWords];
	NSMutableAttributedString *totalWordAttributeStr = [[NSMutableAttributedString alloc]initWithString:totalWordStr];
	[totalWordAttributeStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, totalWordAttributeStr.length)];
	[totalWordAttributeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:24] range:NSMakeRange(0, model.userAllWords.length)];
	[totalWordAttributeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(totalWordAttributeStr.length - 1, 1)];
	self.totalWordLabel.attributedText = totalWordAttributeStr;
	
	
	
	//核心词汇名字
	[self.currentWordLibraryButton setTitle:model.packageName forState:UIControlStateNormal];
	[self.currentWordLibraryButton.titleLabel sizeToFit];
	CGFloat titleWidth = self.currentWordLibraryButton.titleLabel.frame.size.width;
	CGFloat imageWidth = self.currentWordLibraryButton.imageView.frame.size.width;
	self.currentWordLibraryButton.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth, 0, imageWidth);
	self.currentWordLibraryButton.imageEdgeInsets = UIEdgeInsetsMake(0, titleWidth + 5, 0, -titleWidth - 5);

	//进度条
	self.progressBarView.progress = model.userPackageWords.floatValue / model.allWords.floatValue;
	
	//进度 label
	NSString *progressStr = [NSString stringWithFormat:@"进度 : %@/%@",model.userPackageWords,model.allWords];
	NSMutableAttributedString *progressAttributeStr = [[NSMutableAttributedString alloc]initWithString:progressStr];
	[progressAttributeStr addAttribute:NSForegroundColorAttributeName value:[UIColor lg_colorWithType:LGColor_Title_2_Color] range:NSMakeRange(0, progressAttributeStr.length)];
	[progressAttributeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, progressAttributeStr.length)];
	[progressAttributeStr addAttribute:NSForegroundColorAttributeName value:[UIColor lg_colorWithType:LGColor_theme_Color] range:NSMakeRange(5, model.userPackageWords.length)];
	self.progressLabel.attributedText = progressAttributeStr;
	
	//今天需要背单词
	LGStudyType type = [LGUserManager shareManager].user.studyModel;
	NSString *todayStr = [NSString stringWithFormat:@"今天需要背单词 : %@/%@",model.todayWords, model.userPackage.planWords];
	if (type != LGStudyOnlyNew) {
		todayStr = [todayStr stringByAppendingString:[NSString stringWithFormat:@",今日需复习%@/%@",model.userReviewWords, model.userNeedReviewWords]];
	}
	self.todayPlanLabel.text = todayStr;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	
	if ([segue.identifier isEqualToString:@"indexPlanToBeginReciteWords"]) {
		
	}
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end


