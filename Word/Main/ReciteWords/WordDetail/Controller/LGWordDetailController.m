//
//  LGWordDetailController.m
//  Word
//
//  Created by Charles Cao on 2018/2/7.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGWordDetailController.h"
#import "LGWordDetailCell.h"
#import "LGWordDetailHeaderFooterView.h"
#import "LGPlayer.h"
#import "LGWordErrorViewController.h"
#import "LGTodayReviewWordModel.h"
#import "LGFinishWordTaskView.h"
#import "LGWordDetailQuestionCell.h"
#import "LGWordDetailSelectItemCell.h"
#import "LGThirdPartyCell.h"
#import "LGWebController.h"
#import "LGWordDetailShareController.h"

@interface LGWordDetailController () <UITableViewDelegate, UITableViewDataSource,LGThirdPartyCellDelegate, LGWordDetailShareControllerDelegate>

@property (nonatomic, strong) LGWordDetailModel *detailModel; //当前单词,重写 setter 刷新界面

@end

@implementation LGWordDetailController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	if (self.controllerType == LGWordDetailReciteWords)
	{
		[self requestReciteWordsData];
		
	}else if (self.controllerType == LGWordDetailEbbinghausReview)
	{
        self.total = @(self.ebbinghausCount).stringValue;
        self.currentNum = @(self.ebbinghausCount - self.ebbinghausReviewWordIdArray.count+1).stringValue;
        self.title = [NSString stringWithFormat:@"复习(%@/%@)",self.currentNum,self.total];
		[self requestWordDetailWidthID:self.ebbinghausReviewWordIdArray.firstObject];
			
	}else if (self.controllerType == LGWordDetailTodayReview)
	{
		[self requestTodayReviewWord];
		[self.vagueOrForgotButton setTitle:@"忘记" forState:UIControlStateNormal];
				
	}else if (self.controllerType == LGWordDetailReview)
	{
        switch (self.reviewTyep) {
            case LGSelectReviewChinese_English:
                self.translateLabel.hidden = YES;
                break;
            case LGSelectReviewEnglish_Chinese:
                self.wordLabel.hidden = YES;
                break;
            case LGSelectReviewDictation:
                self.translateLabel.hidden = YES;
                self.wordLabel.hidden = YES;
                break;
            default:
                break;
        }
		[self.vagueOrForgotButton setTitle:@"忘记" forState:UIControlStateNormal];
		self.currentNum = @(self.total.integerValue - self.reviewWordIdArray.count + 1).stringValue;
		[self requestWordDetailWidthID:self.reviewWordIdArray.firstObject];
	
	}else if (self.controllerType == LGWordDetailDictationPrompt)
	{
		self.statusViewHeightConstraint.constant = 0;
		self.detailModel = self.dictationPromptWord;
		self.familiarItemButton.hidden = YES;
        self.masksView.hidden = YES;
		self.title = @"听写练习";
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"backArrow"] style:UIBarButtonItemStylePlain target:self action:@selector(dismissController)];
    }else if (self.controllerType == LGWordDetailSearch){
        self.title = self.searchWordStr;
        self.statusViewHeightConstraint.constant = 0;
        self.familiarItemButton.hidden = YES;
        [self requestWordDetailWidthID:self.searchWordID];
    }
	
	[self.wordTabelView registerNib:[UINib nibWithNibName:@"LGWordDetailHeaderFooterView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"LGWordDetailHeaderFooterView"];
}

#pragma mark - Setter  Getter

- (void)setCurrentNum:(NSString *)currentNum{
	_currentNum = currentNum;
	self.title = [NSString stringWithFormat:@"%ld/%ld",currentNum.integerValue,self.total.integerValue];
}

- (void)setTotal:(NSString *)total{
	_total = total;
	self.title = [NSString stringWithFormat:@"%ld/%ld",self.currentNum.integerValue,total.integerValue];
}

- (void)setDetailModel:(LGWordDetailModel *)detailModel {
	_detailModel = detailModel;
	self.wordLabel.text = detailModel.words.word;
	self.translateLabel.text = detailModel.words.translate;
	if (detailModel.did) {
		self.currentNum = @(detailModel.did.integerValue + 1).stringValue;
	}
    [self playeAction:nil];
    self.playerButton.hidden = NO;
    if (detailModel.words.phonetic_us) {
        [self.playerButton setTitle:[NSString stringWithFormat:@"  %@",detailModel.words.phonetic_us] forState:UIControlStateNormal];
    }
	
	self.title = [NSString stringWithFormat:@"%@ (认知率: %@%%)",self.title, detailModel.percent];
	
	[self.wordTabelView reloadData];
}

#pragma mark - 请求数据

/**
 * 请求背单词接口,code = 98进入复习模式
 */
- (void)requestReciteWordsData {
	
	[LGProgressHUD showHUDAddedTo:self.view];
    __weak typeof(self) weakSelf = self;
	[self.request requestReciteWordsCompletion:^(id response, LGError *error) {
		if ([self isNormal:error]) {
			NSInteger code = [NSString stringWithFormat:@"%@",response[@"code"]].integerValue;
			if (code == 1){
				self.detailModel = [LGWordDetailModel mj_objectWithKeyValues:response];
			}else if (code == 98){
				[self requestEbbinghausReviewWordArray];
            }else if (code == 2){
                //没有单词了
                [LGProgressHUD showMessage:response[@"message"] toView:self.view completionBlock:^{
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }];
			}else if (code == 96){
				//今日已完成
                [self performSegueWithIdentifier:@"wordDetailToShare" sender:nil];
			}
		}
	}];
}

/**
 通过单词id请求单词详情
 
 @param wordID 单词id
 */
- (void)requestWordDetailWidthID:(NSString *)wordID{
	[LGProgressHUD showHUDAddedTo:self.view];
	[self.request requestWordDetailWidthID:wordID completion:^(id response, LGError *error) {
		if ([self isNormal:error]) {
			self.detailModel = [LGWordDetailModel mj_objectWithKeyValues:response];
		}
	}];
}

/**
 请求艾宾浩斯复习列表
 code = 0 没有复习内容,不提示,直接跳到下一个单词
 */
- (void)requestEbbinghausReviewWordArray{
	[self.request requestEbbinghausReviewList:^(id response, LGError *error) {
		NSString *code = [NSString stringWithFormat:@"%@",response[@"code"]];
		if ([code isEqualToString:@"0"]) {
			[self pushNextWordDetailController:LGWordDetailReciteWords animated:YES];
		}else if ([self isNormal:error]) {
			self.ebbinghausReviewWordIdArray  = [NSMutableArray arrayWithArray:response[@"words"]];
            self.ebbinghausCount = self.ebbinghausReviewWordIdArray.count;
			[self pushNextWordDetailController:LGWordDetailEbbinghausReview animated:NO];
		}
	}];
}


/**
 请求今日复习单词
 */
- (void)requestTodayReviewWord {
	
	[self.request requestTodayReviewWordsWithStatus:self.todayReviewStatus completion:^(id response, LGError *error) {
		if ([self isNormal:error]) {
			LGTodayReviewWordModel *reviewWordModel = [LGTodayReviewWordModel mj_objectWithKeyValues:response];
			self.total = reviewWordModel.all;
			self.currentNum = @(reviewWordModel.did.integerValue + 1).stringValue;
			[self requestWordDetailWidthID:reviewWordModel.wordsId];
		}
	}];
}

//继续背单词
- (void)continueReciteWords{
    [LGProgressHUD showHUDAddedTo:self.view];
    [self.request requestIsReciteWordsCompletion:^(id response, LGError *error) {
        if ([self isNormal:error]) {
			//把当前序号+1,避免重复判断背完
			NSInteger nextIndx = self.currentNum.integerValue + 1 ;
			self.currentNum = @(nextIndx).stringValue;
            [self pushNextWordDetailController:LGWordDetailReciteWords animated:YES];
        }
    }];
}

#pragma mark -

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark - Action

//播放语音
- (IBAction)playeAction:(id)sender {
	[[LGPlayer sharedPlayer] playWithUrl:self.detailModel.words.us_audio completion:^(LGError *error) {
		[self isNormal:error];
	}];
}

//隐藏遮罩层
- (IBAction)hiddenMasksAction:(id)sender {
	self.masksView.hidden = YES;
    self.translateLabel.hidden = NO;
    self.wordLabel.hidden = NO;
}

//熟识
- (IBAction)familiarAction:(id)sender {
	[self updateWordStatus:LGWordStatusFamiliar];
}

//认识
- (IBAction)knowAction:(id)sender {
	[self updateWordStatus:LGWordStatusKnow];
}

//不认识
- (IBAction)notKnowAction:(id)sender {
	[self updateWordStatus:LGWordStatusIncognizance];
}

// 在背单词模式下标记为模糊,其他复习模式下标记为忘记
- (IBAction)vagueOrForgotAction:(id)sender {
	
	[self updateWordStatus:self.controllerType == LGWordDetailReciteWords ? LGWordStatusVague : LGWordStatusForget];
}

- (void)dismissController{
	[self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 修改单词状态

- (void)updateWordStatus:(LGWordStatus) status{
	
	if (self.detailModel.words.ID == nil) return;
	
	switch (self.controllerType) {
		case LGWordDetailReciteWords:
			[self updateReciteWordStatus:status];
			break;
			
		case LGWordDetailEbbinghausReview:
			[self updateEbbinghausReviewWordStatus:status];
			break;
			
		case LGWordDetailTodayReview:
			[self updateReviewWordStatus:status];
			break;
		case LGWordDetailReview:
			[self updateReviewWordStatus:status];
			break;
		default:
			break;
	}
}


/**
 背单词模式下更新单词状态,并跳转到下一个单词
 
 @param status 单词状态
 */
- (void)updateReciteWordStatus:(LGWordStatus) status {
	[LGProgressHUD showHUDAddedTo:self.view];
	[self.request updateWordStatus:self.detailModel.words.ID status:status completion:^(id response, LGError *error) {
		if ([self isNormal:error]) {
			[self pushNextWordDetailController:LGWordDetailReciteWords  animated:YES];
		}
	}];
}


/**
 在艾宾浩斯复习模式下更新单词状态,并跳转到下一个单词
 循环复习 id 列表, 如果标记单词为认识,则从复习id列表中移除该单词,
 如果标记为其他状态,则把该单词移动到复习列表最后,直到所有单词都标记为认识
 当复习id列表为空时,进入背单词模式(LGWordDetailReciteWords)
 
 @param status 单词状态
 */
- (void)updateEbbinghausReviewWordStatus:(LGWordStatus) status {
	[LGProgressHUD showHUDAddedTo:self.view];
	[self.request updateWordStatus:self.detailModel.words.ID status:status completion:^(id response, LGError *error) {
		if ([self isNormal:error]) {
			NSString *wordID = self.ebbinghausReviewWordIdArray.firstObject;
			[self.ebbinghausReviewWordIdArray removeObjectAtIndex:0];
			if (status != LGWordStatusKnow) {
				[self.ebbinghausReviewWordIdArray addObject:wordID];
			}
			LGWordDetailControllerType tempType = ArrayNotEmpty(self.ebbinghausReviewWordIdArray) ? LGWordDetailEbbinghausReview : LGWordDetailReciteWords;
			//艾宾浩斯完成后, title 总数显示为今日需背单词数
			if (tempType == LGWordDetailReciteWords) {
				self.total = self.todayNeedReciteNum;
			}
			[self pushNextWordDetailController:tempType  animated:YES];
		}
	}];
}


/**
 复习模式下修改单词状态,并跳转到下一个单词
 
 @param status 单词状态
 */
- (void)updateReviewWordStatus:(LGWordStatus) status {
	[LGProgressHUD showHUDAddedTo:self.view];
	[self.request updateReviewWordStatus:status wordId:self.detailModel.words.ID completion:^(id response, LGError *error) {
		if ([self isNormal:error]) {
			if (self.controllerType == LGWordDetailReview) {
				[self.reviewWordIdArray removeObjectAtIndex:0];
			}
			[self pushNextWordDetailController:self.controllerType  animated:YES];
		}
	}];
}

/**
 跳转到下一个 WordDetailController
 @param type  下一个 controller 的模式
 @param animated 是否跳转动画
 */
- (void)pushNextWordDetailController:(LGWordDetailControllerType) type animated:(BOOL)animated{
	
	
	//在"今日复习"或者 "错题本复习/时间复习" 模式下,当当前进度等于总进度时.弹出复习完成框
	if ((self.controllerType == LGWordDetailTodayReview ||
		self.controllerType == LGWordDetailReview)  &&
		self.currentNum.integerValue == self.total.integerValue) {
		
		//显示完成提示框
		[LGFinishWordTaskView showReviewFinishToView:self.view.window sureBlock:^{
			[self.navigationController popViewControllerAnimated:YES];
		}];
	}else{
		LGWordDetailController *wordDetailController = STORYBOARD_VIEWCONTROLLER(@"ReciteWords", @"LGWordDetailController");
		wordDetailController.controllerType = type;
		wordDetailController.todayNeedReciteNum = self.todayNeedReciteNum;
		wordDetailController.total = self.total;
		wordDetailController.reviewWordIdArray = self.reviewWordIdArray;
		wordDetailController.ebbinghausReviewWordIdArray = self.ebbinghausReviewWordIdArray;
        wordDetailController.ebbinghausCount = self.ebbinghausCount;
		wordDetailController.todayReviewStatus = self.todayReviewStatus;
		NSMutableArray *controllerArray = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
		[controllerArray removeObject:self];
		[controllerArray addObject:wordDetailController];
		[self.navigationController setViewControllers:controllerArray animated:animated];
	}
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return self.detailModel.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	//最后一个section 为第三方词典接口
	if (section == [tableView numberOfSections] - 1) {
		return 1;
	}else{
		return self.detailModel.dataSource[section].cellContent.count;
	}
	
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	LGWordDetailTableDataSource *dataSource = self.detailModel.dataSource[indexPath.section];
	
	if (dataSource.type == LGDataSourceText) {
		LGWordDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LGWordDetailCell"];
		NSString *content = dataSource.cellContent[indexPath.row];
		BOOL isFirst = indexPath.row == 0;
		BOOL isLast  = indexPath.row == [tableView numberOfRowsInSection:indexPath.section] - 1;
		[cell setContentStr:content isFirst:isFirst isLast:isLast];
		return cell;
	}else if(dataSource.type == LGDataSourceQuestion){
		if (indexPath.row == 0) {
			LGWordDetailQuestionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LGWordDetailQuestionCell"];
			
            [cell setQuestion:dataSource.cellContent[0] word:self.detailModel.words.word completion:^{
                [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            }];
			return cell;
		}else{
			LGWordDetailSelectItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LGWordDetailSelectItemCell"];
           
			[cell setSelectedItem:dataSource.cellContent[indexPath.row] completion:^{
				 [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
			}];
			return cell;
		}
	}else{
		LGThirdPartyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LGThirdPartyCell"];
		cell.delegate = self;
		return cell;
	}
}

#pragma mark - UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	LGWordDetailHeaderFooterView *heaerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LGWordDetailHeaderFooterView"];
	heaerView.titleLabel.text = self.detailModel.dataSource[section].sectionTitle;
	return heaerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell isKindOfClass:[LGWordDetailSelectItemCell class]]) {
        
        tableView.allowsSelection = NO;
        
      __block  NSMutableArray <NSIndexPath *> *reloadIndexPath = [NSMutableArray array];
        [reloadIndexPath addObject:indexPath];
        LGQuestionSelectItemModel *itemModel = ((LGWordDetailSelectItemCell *)cell).selectedItem;
        itemModel.isShowRightOrWrong = YES;
        
        LGWordDetailTableDataSource *dataSource = self.detailModel.dataSource[indexPath.section];
        [dataSource.cellContent enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:LGQuestionSelectItemModel.class]) {
                LGQuestionSelectItemModel *itemModel = obj;
                if ([itemModel.name isEqualToString:self.detailModel.question.questionanswer]) {
                    itemModel.isRightAnswer = YES;
                    itemModel.isShowRightOrWrong = YES;
                    *stop = YES;
                    NSIndexPath *path = [NSIndexPath indexPathForRow:idx inSection:indexPath.section];
                    [reloadIndexPath addObject:path];
                }
            }
        }];
        [tableView reloadRowsAtIndexPaths:reloadIndexPath withRowAnimation:UITableViewRowAnimationNone];
    }
    
}

#pragma mark - LGThirdPartyCellDelegate
- (void)selectedThirdParty:(LGThirdPartyType)type{
    NSString *url;
    NSString *word = self.detailModel.words.word;
    if (type == LGThirdPartyYouDao) {
        url = [NSString stringWithFormat:@"http://m.youdao.com/dict?le=eng&q=%@",word];
    }else if (type == LGThirdPartyJinShan){
        url = [NSString stringWithFormat:@"http://www.iciba.com/%@",word];
    }else if (type == LGThirdPartyBiYing){
        url = [NSString stringWithFormat:@"https://cn.bing.com/dict/search?q=%@",word];
    }else{
		url = [NSString stringWithFormat:@"https://www.oxfordlearnersdictionaries.com/definition/english/%@",word];
    }
    if (url) {
        AXWebViewController *web = [[AXWebViewController alloc]initWithAddress:url];
        [self.navigationController pushViewController:web animated:YES];
    }
}

#pragma mark - LGWordDetailShareControllerDelegate
- (void)dismissShareController{
	[self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString:@"WordDetailToError"]) {
		LGWordErrorViewController *controller = segue.destinationViewController;
		controller.wordID = self.detailModel.words.ID;
	}else if ([segue.identifier isEqualToString:@"wordDetailToShare"]){
		LGWordDetailShareController *controller = segue.destinationViewController;
		controller.delegate = self;
	}
	// Get the new view controller using [segue destinationViewController].
	// Pass the selected object to the new view controller.
}


@end

@implementation LGWordDetailHeaderView

- (void)drawRect:(CGRect)rect{
	
	CGFloat grayHeight = 20.0;
	
	UIBezierPath *path = [[UIBezierPath alloc]init];
	[path moveToPoint:CGPointMake(0, CGRectGetWidth(rect))];
	[path addLineToPoint:CGPointMake(0, CGRectGetHeight(rect) - grayHeight)];
	
	[path addCurveToPoint:CGPointMake(CGRectGetWidth(rect), CGRectGetHeight(rect)  - grayHeight) controlPoint1:CGPointMake(CGRectGetMidX(rect) / 4 * 3, CGRectGetHeight(rect) + grayHeight) controlPoint2:CGPointMake(CGRectGetMidX(rect)/4 * 5, CGRectGetHeight(rect) - grayHeight * 3)];
	[path addLineToPoint:CGPointMake(CGRectGetWidth(rect), CGRectGetHeight(rect))];
	[path closePath];
	[[UIColor lg_colorWithHexString:@"F1F1F1"]setFill];
	[path fill];
}

@end
