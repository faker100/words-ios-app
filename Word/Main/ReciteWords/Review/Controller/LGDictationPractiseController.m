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
#import "UIScrollView+LGRefresh.h"
#import "NSString+LGString.h"
#import "LGTool.h"
#import "LGDictationPromptController.h"
#import "LGFinishWordTaskView.h"

@interface LGDictationPractiseController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) LGWordDetailModel *wordDetailModel;

//答案拆分个数
@property (nonatomic, assign) NSInteger answerItemNum;

//用户答案数组,默认元素都为 @""
@property (nonatomic, strong) NSMutableArray <NSString *> *userAnswerArray;

//打乱顺序的答案选项数组
@property (nonatomic, strong) NSMutableArray <NSString *> *answerItemArray;

@end

@implementation LGDictationPractiseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[self requestData:YES];
	[self beginCountDown];
	[self configUserInterface];
	
}

- (void)configUserInterface{
	
	self.currentNum = @(self.total.integerValue - self.wordIDArray.count +1).stringValue;
	
    __weak typeof(self) weakSelf = self;
	[self.scrollView setHeaderRefresh:^{
		[weakSelf requestData:NO];
	}];
}

- (void)requestData:(BOOL)animation {
	
	if (animation) {
		[LGProgressHUD showHUDAddedTo:self.view];
	}
	[self.request requestWordDetailWidthID:self.wordIDArray.firstObject completion:^(id response, LGError *error) {
		[self.scrollView lg_endRefreshing];
		if ([self isNormal:error]) {
			self.wordDetailModel = [LGWordDetailModel mj_objectWithKeyValues:response];
		}
	}];
}


/**
 配置用户答案 collection
 */
- (void)configUserAnswerCollection{
	UICollectionViewFlowLayout *userAnswerCollectionLayout = (UICollectionViewFlowLayout *)self.userAnswerCollection.collectionViewLayout;
	
	//用户答案 cell 宽度
	NSInteger userAnswerCellWidth = 50;
	userAnswerCollectionLayout.itemSize = CGSizeMake(userAnswerCellWidth, 40);
	
	
	//cell 间距,屏幕宽度均分除 cell 以外的剩余空间, 最大为 12,(屏幕宽度 - 所有 cell 宽度)/(cell 数量 + 1)
	CGFloat cellSpace = MIN(12, (SCREEN_WIDTH - userAnswerCellWidth * self.answerItemNum)  / (self.answerItemNum + 1));
	userAnswerCollectionLayout.minimumLineSpacing = cellSpace;
	userAnswerCollectionLayout.minimumInteritemSpacing = 0;
	
	//为了 cell 居中显示 设置collection 左右 contentInset,(屏幕宽度 - 所有cell宽度 - 所有 cell 间距)/2
	CGFloat contentInsetSpace = (SCREEN_WIDTH - userAnswerCellWidth * self.answerItemNum - cellSpace * (self.answerItemNum - 1)) / 2.0f;
	self.userAnswerCollection.contentInset = UIEdgeInsetsMake(0, contentInsetSpace, 0, contentInsetSpace);
	[self.userAnswerCollection reloadData];
}


/**
 配置答案选项 collection
 */
- (void)configAnswerItemCollection{
	UICollectionViewFlowLayout *answerCollectionLayout = (UICollectionViewFlowLayout *)self.answerCollection.collectionViewLayout;
	/**
	 随便取一个答案片段,来计算答案所需宽度
	 */
	NSString *str = self.answerItemArray.firstObject;
	
	/**
	 设置 cell 宽度为文本所需宽度
	 */
	CGFloat cellWidth = [str getStringRectWidthOfHeight:14.0f fontSize:14.0f];
	
	/**
	 cell 中 label 左右间距为 5 (5 * 2);
	 */
	cellWidth += 10;
	
	CGSize collectionSize = self.answerCollection.bounds.size;
	
	/**
	 cell水平最小间距最 20;
	 调整所有cell宽度总和不能超过collection最大宽度,(collection宽度 - 所有 cell 水平间距) / 每行最大 cell 数量 3
	 */
	cellWidth = MIN((collectionSize.width - 4 * 20) / 3.0, cellWidth);
	
	/**
	 调整 cell 宽度最小为50;
	 */
	cellWidth = MAX(50, cellWidth);
	
	/**
	 默认cell 宽度高度相等
	 */
	CGFloat cellHeight = cellWidth;
	
	/**
	 cell 垂直最小间距为20
	 调整cell 高度总和不能超过collection最大高度 (collection高度 - 所有 cell 垂直间距) / 每列最大 cell 数量 2
	 */
	cellHeight = MIN((collectionSize.height - 3 * 20) / 2.0 , cellHeight);
	answerCollectionLayout.itemSize = CGSizeMake(cellWidth, cellHeight);
	
	
	/**
	 cell 水平间距,(collectionSize宽度 - 宽度 * 每行最多cell数量3) / 间距数量 4
	 */
	CGFloat interitemSpace = (collectionSize.width - cellWidth * 3) / 4.0f;
	
	/**
	 cell 垂直间距
	 */
	CGFloat lineSpace = (collectionSize.height - cellHeight * 2) / 3.0f;
	answerCollectionLayout.minimumInteritemSpacing = interitemSpace;
	answerCollectionLayout.minimumLineSpacing = lineSpace;

	self.answerCollection.contentInset = UIEdgeInsetsMake(lineSpace, interitemSpace, lineSpace, interitemSpace);
	[self.answerCollection reloadData];
	
}

#pragma mark - setter getter

- (void)setCurrentNum:(NSString *)currentNum{
	_currentNum = currentNum;
	self.title = [NSString stringWithFormat:@"%ld/%ld",currentNum.integerValue,self.total.integerValue];
}

- (void)setTotal:(NSString *)total{
	_total = total;
	self.title = [NSString stringWithFormat:@"%ld/%ld",self.currentNum.integerValue,total.integerValue];
}

- (void)setWordDetailModel:(LGWordDetailModel *)wordDetailModel {
	_wordDetailModel = wordDetailModel;
	[self playerAction:nil];
	//先重置数据
	self.answerItemNum = 0;
	self.userAnswerArray = nil;
	self.answerItemArray = nil;
	
	self.translateLabel.text = wordDetailModel.words.translate;
	[self.playerButton setTitle:wordDetailModel.words.phonetic_us forState:UIControlStateNormal];
	
	[self configUserAnswerCollection];
	[self configAnswerItemCollection];
	
}

//获取选择答案,默认情况每个元素为 @"";
- (NSMutableArray<NSString *> *)userAnswerArray{
	if ( (!_userAnswerArray) || _userAnswerArray.count != self.answerItemNum) {
		_userAnswerArray = [NSMutableArray array];
		for (int i = 0; i < self.answerItemNum; i++) {
			[_userAnswerArray addObject:@""];
		}
	}
	return _userAnswerArray;
}

//获取单词拆分数组
- (NSMutableArray<NSString *> *)answerItemArray{
	if (!_answerItemArray) {
		_answerItemArray = [NSMutableArray array];
		NSString *word = self.wordDetailModel.words.word;
		NSInteger remainder = word.length % self.answerItemNum; //均分后的多余字符长度
		//每个片段字符长度数组
		NSMutableArray <NSNumber *> *itemLengthArray = [NSMutableArray array];
		//平均分配每个片段中的长度,不能均分的时候,前 N(remainder) 个片段多一个字符
		for (int i = 0; i < self.answerItemNum; i++) {
			NSInteger length = word.length / self.answerItemNum;
			if (i < remainder) {
				length += 1;
			}
			[itemLengthArray addObject:@(length)];
		}
		//随机打乱片段长度数组
		[itemLengthArray sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
			return arc4random_uniform(3) - 1;
		}];
		
		//按片段长度数组分割字符串
		__block NSInteger location = 0;
		[itemLengthArray enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
			NSString *sub = [word substringWithRange:NSMakeRange(location, obj.integerValue)];
			[_answerItemArray addObject:sub];
			location += obj.integerValue;
		}];
		
		//随机打乱分割后的数组
		[_answerItemArray sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
			return arc4random_uniform(3) - 1;
		}];
	}
	return _answerItemArray;
}

/**
 随机生成答案个数
 单词字母数 <= 4 拆分成 单词字母数个数
		  <=5  拆分成  4或5个
          <=24 拆分成  4或5或6个
          >24  拆分成  6个
 */
- (NSInteger)answerItemNum{
	if (_answerItemNum > 0) {
		return _answerItemNum;
	}else{
		NSString *word = self.wordDetailModel.words.word;
		if	    (word.length == 0) _answerItemNum = 0;
		else if (word.length <= 4) _answerItemNum = word.length;
		else if (word.length <= 5) _answerItemNum = arc4random_uniform(2) + 4;
		else if (word.length <= 24)_answerItemNum = arc4random_uniform(3) + 4;
		else	_answerItemNum = 6;
		return _answerItemNum;
	}
}

#pragma mark -

//倒计时
- (void)beginCountDown {
	
    __weak typeof(self) weakSelf = self;
	[LGTool beginCountDownWithSecond:16 completion:^(NSInteger currtentSecond) {
		[weakSelf.countDownButton setTitle:@(currtentSecond).stringValue forState:UIControlStateNormal];
	}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//语音播放
- (IBAction)playerAction:(id)sender {
	[[LGPlayer sharedPlayer]playWithUrl:self.wordDetailModel.words.us_audio completion:nil];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.answerItemNum;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == self.userAnswerCollection) {
        LGDictationUserAnswerCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LGDictationUserAnswerCollectionCell" forIndexPath:indexPath];
		cell.userAnswerLabel.text = self.userAnswerArray[indexPath.row];
        return cell;
        
    }else{
        LGDictationAnswerItemCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LGDictationAnswerItemCollectionCell" forIndexPath:indexPath];
		cell.answerLabel.text = self.answerItemArray[indexPath.row];
        return cell;
    }
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
	
	[collectionView deselectItemAtIndexPath:indexPath animated:YES];
	if (collectionView == self.answerCollection) {
		__block BOOL isFinish = NO;
		 __weak typeof(self) weakSelf = self;
		//把所选片段替换到用户答案数组中第一个为 @"" 的地方
		[self.userAnswerArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
			if (obj.length == 0) {
				weakSelf.userAnswerArray[idx] = weakSelf.answerItemArray[indexPath.row];
				*stop = YES;
			}
		}];
		
		[self.userAnswerCollection reloadData];
		
		//判断是否所有答案都选了
		[self.userAnswerArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
			isFinish = obj.length > 0;
			*stop = !isFinish;
		}];
		
		if (isFinish) {
			[self isSure];
		}
	}else{
		self.userAnswerArray[indexPath.row] = @"";
		[self.userAnswerCollection reloadData];
	}
	
}

#pragma mark -

//判断答案是否正确
- (void)isSure{
	
	__block NSMutableString *userAnswer = [NSMutableString string];
	[self.userAnswerArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		[userAnswer appendString:obj];
	}];
	if ([userAnswer isEqualToString:self.wordDetailModel.words.word]) {
		
		if (self.currentNum.integerValue == self.total.integerValue) {
			[LGFinishWordTaskView showFinishToView:self.view type:LGFinishReview sureBlock:^{
				[self.navigationController popViewControllerAnimated:YES];
			}];
		}else{
			LGDictationPractiseController *nextController = STORYBOARD_VIEWCONTROLLER(@"ReciteWords", @"LGDictationPractiseController");
			[self.wordIDArray removeObjectAtIndex:0];
			nextController.wordIDArray = self.wordIDArray;
			nextController.total = self.total;
			NSMutableArray *viewControllers = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
			[viewControllers removeObject:self];
			[viewControllers addObject:nextController];
			[self.navigationController setViewControllers:viewControllers animated:YES];
		}
	}else{
		NSLog(@"no");
	}
	
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	
	if ([segue.identifier isEqualToString:@"dictationToWordDetail"]){
		LGDictationPromptController *navigationController = segue.destinationViewController;
		LGWordDetailController *wordDetailController = navigationController.viewControllers.firstObject;
		wordDetailController.dictationPromptWord = self.wordDetailModel;
		wordDetailController.controllerType = LGWordDetailDictationPrompt;
	}
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
