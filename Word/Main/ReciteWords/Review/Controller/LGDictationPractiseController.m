//
//  LGDictationPractiseController.m
//  Word
//
//  Created by Charles Cao on 2018/3/6.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGDictationPractiseController.h"
#import "LGWordDetailModel.h"
#import "LGPlayer.h"
#import "LGDictationAnswerItemCollectionCell.h"
#import "LGDictationUserAnswerCollectionCell.h"

@interface LGDictationPractiseController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) LGWordDetailModel *wordDetailModel;

//答案拆分个数
@property (nonatomic, assign) NSInteger answerItemNum;

@end

@implementation LGDictationPractiseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[self requestData];
	[self beginCountDown];
}

- (void)requestData {
	[LGProgressHUD showHUDAddedTo:self.view];
	[self.request requestWordDetailWidthID:self.wordIDArray.firstObject completion:^(id response, LGError *error) {
		if ([self isNormal:error]) {
			self.wordDetailModel = [LGWordDetailModel mj_objectWithKeyValues:response];
		}
	}];
}

- (void)setWordDetailModel:(LGWordDetailModel *)wordDetailModel {
	_wordDetailModel = wordDetailModel;
	self.translateLabel.text = wordDetailModel.words.translate;
	[self.playerButton setTitle:wordDetailModel.words.phonetic_us forState:UIControlStateNormal];
    
//    UICollectionViewLayout *userAnswerCollectionLayout =
    
}


/**
 随机生成答案个数
 单词字母数 <= 4 拆分成 单词字母数个数
		  <=5  拆分成  4或5个
          <=24 拆分成  4或5或6个
          >24  拆分成  6个
 */
- (NSInteger)answerItemNum{
	NSString *word = self.wordDetailModel.words.word;
	if (_answerItemNum > 0) {
		return _answerItemNum;
	}else{
		if	    (word.length == 0) _answerItemNum = 0;
		else if (word.length <= 4) _answerItemNum = word.length;
		else if (word.length <= 5) _answerItemNum = 4 + arc4random() % 2;
		else if (word.length <= 24)_answerItemNum = 4 + arc4random() % 3;
		else	_answerItemNum = 6;
	}
	return _answerItemNum;
}

//倒计时
- (void)beginCountDown{
	__block int timeout = 16;
	//创建timer
	dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
	//设置1s触发一次，0s的误差
	dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
	//触发的事件
	dispatch_source_set_event_handler(_timer, ^{
		if(timeout<=0){ //倒计时结束，关闭
			//取消dispatch源
			dispatch_source_cancel(_timer);
		}
		else{
			timeout--;
			dispatch_async(dispatch_get_main_queue(), ^{
				//更新主界面的操作
				[self.countDownButton setTitle:@(timeout).stringValue forState:UIControlStateNormal];
			});
		}
	});
	//开始执行dispatch源
	dispatch_resume(_timer);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playerAction:(id)sender {
	[[LGPlayer sharedPlayer]playWithUrl:self.wordDetailModel.words.us_audio completion:nil];
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.answerItemNum;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == self.userAnswerCollection) {
        
        LGDictationUserAnswerCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LGDictationUserAnswerCollectionCell" forIndexPath:indexPath];
        return cell;
        
    }else{
        
        LGDictationAnswerItemCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LGDictationAnswerItemCollectionCell" forIndexPath:indexPath];
        return cell;
    }
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
