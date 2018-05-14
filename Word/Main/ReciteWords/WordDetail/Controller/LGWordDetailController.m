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
#import "LGUserManager.h"

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
     //   self.title = [NSString stringWithFormat:@"复习(%@/%@)",self.currentNum,self.total];
		[self requestWordDetailWidthID:self.ebbinghausReviewWordIdArray.firstObject];
			
	}else if (self.controllerType == LGWordDetailTodayReview)
	{
		[self requestTodayReviewWord];
		[self.vagueOrForgotButton setTitle:@"忘记" forState:UIControlStateNormal];

	}else if (self.controllerType == LGWordDetailReview)
	{
        switch (self.reviewTyep) {
            case LGSelectReviewEnglish_Chinese:
                self.translateLabel.hidden = YES;
                break;
            case LGSelectReviewChinese_English:
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
		self.navigationItem.leftBarButtonItem = nil; //去除左边("新学"/复习) title
	}else if (self.controllerType == LGwordDetailTodayEbbinghausReview){
		[self requestWordDetailWidthID:self.ebbinghausReviewWordIdArray.firstObject];
	}

    [self configTabelView];
	
}

//初始化table headerview
- (void)configTabelView{
    [self.wordTabelView registerNib:[UINib nibWithNibName:@"LGWordDetailHeaderFooterView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"LGWordDetailHeaderFooterView"];
    CGFloat fontRate = [LGUserManager shareManager].user.fontSizeRate.floatValue;
    self.wordLabel.font = [UIFont systemFontOfSize:self.wordLabel.font.pointSize  + fontRate];
    self.translateLabel.font = [UIFont systemFontOfSize:self.translateLabel.font.pointSize + fontRate];
    self.knowRateLabel.font = [UIFont systemFontOfSize:self.knowRateLabel.font.pointSize + fontRate];
}

#pragma mark - Setter  Getter

/*  暂时不需要标题更新
- (void)setCurrentNum:(NSString *)currentNum{
	_currentNum = currentNum;
	self.title = [NSString stringWithFormat:@"%ld/%ld",currentNum.integerValue,self.total.integerValue];
}

- (void)setTotal:(NSString *)total{
	_total = total;
	self.title = [NSString stringWithFormat:@"%ld/%ld",self.currentNum.integerValue,total.integerValue];
}
*/

//更新左边 title
//新艾宾浩斯复习量为 needReviewWords + 剩余复习单词亮
- (void)updateLeftTitle{
	
	NSInteger needReviewWords = self.detailModel.userNeedReviewWords;
	//新艾宾浩斯复习量为 needReviewWords + 剩余复习单词亮
	if (self.controllerType == LGWordDetailEbbinghausReview) {
		needReviewWords = self.detailModel.needReviewWords + self.ebbinghausReviewWordIdArray.count;
	}
	
	NSString *leftTitle = [NSString stringWithFormat:@" 新学%ld | 需复习%ld ",self.detailModel.did,needReviewWords];
	
	
	if (self.controllerType == LGWordDetailReview) {
//		NSInteger surplus = self.total.integerValue - self.currentNum.integerValue;
		leftTitle = [NSString stringWithFormat:@" 需复习%ld ",self.reviewWordIdArray.count];
	}
	
	[self.leftTitleButton setTitle:leftTitle forState:UIControlStateNormal];
	[self.leftTitleButton sizeToFit];
	self.leftTitleButton.hidden = NO;
}

- (void)setDetailModel:(LGWordDetailModel *)detailModel {
	_detailModel = detailModel;
	self.wordLabel.text = detailModel.words.word;
	self.translateLabel.text = detailModel.words.translate;
	
    [self.wordLabel sizeToFit];
    [self.translateLabel sizeToFit];
    
	//在不是搜索(LGWordDetailSearch)和提示(LGWordDetailDictationPrompt)模式下,更新左边标题
	if (self.controllerType != LGWordDetailSearch && self.controllerType != LGWordDetailDictationPrompt) {
		self.currentNum = @(detailModel.did).stringValue;
		[self updateLeftTitle];
	}
    
    //播放音频
    [self playeAction:nil];
    self.playerButton.hidden = NO;
    if (detailModel.words.phonetic_us) {
        [self.playerButton setTitle:[NSString stringWithFormat:@"  %@",detailModel.words.phonetic_us] forState:UIControlStateNormal];
    }
	
	self.knowRateLabel.text = [NSString stringWithFormat:@"认知率: %@%%",detailModel.percent];
	self.knowRateLabel.hidden = NO;
	
	[self.wordTabelView.tableHeaderView sizeToFit];
    CGSize size = [self.wordTabelView.tableHeaderView sizeThatFits:CGSizeZero];
    NSLog(@"%f,%f",size.width, size.height);
	
	[self.wordTabelView reloadData];
}

#pragma mark - 请求数据

/**
 * 请求背单词接口,code = 98进入复习模式
   code == 96,今日任务完成弹出分享
   code == 95,今日复习前N天的艾宾浩斯
   code == 2,完成词包
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
				//今日已完成,弹出分享
                [self performSegueWithIdentifier:@"wordDetailToShare" sender:nil];
			}else if(code == 95){
				//今日复习前N天的艾宾浩斯
				[self pushNextWordDetailController:LGWordDetailTodayReview animated:NO];
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
	__weak typeof(self) weakSelf = self;
	[self.request requestEbbinghausReviewList:^(id response, LGError *error) {
		NSString *code = [NSString stringWithFormat:@"%@",response[@"code"]];
		
		//新艾宾浩斯没有复习内容
		if ([code isEqualToString:@"0"]) {
			[weakSelf.request finishEbbinghausCompletion:^(id response, LGError *error) {
				if ([self isNormal:error]) {
					[weakSelf pushNextWordDetailController:LGWordDetailReciteWords animated:NO];
				}
			}];
			
		}else if ([self isNormal:error]) {
			self.ebbinghausReviewWordIdArray  = [NSMutableArray arrayWithArray:response[@"words"]];
            self.ebbinghausCount = self.ebbinghausReviewWordIdArray.count;
			[self pushNextWordDetailController:LGWordDetailEbbinghausReview animated:NO];
		}
	}];
}


/**
 请求今日复习前几天的艾宾浩斯单词
 */
- (void)requestTodayReviewWord {
	
	[self.request requestTodayReviewWordsCompletion:^(id response, LGError *error) {
		if ([self isNormal:error]) {
			NSInteger code = [NSString stringWithFormat:@"%@",response[@"code"]].integerValue;
			if (code == 2){
				//老艾宾浩斯完成了,进分享
				[self performSegueWithIdentifier:@"wordDetailToShare" sender:nil];
			}else{
				LGTodayReviewWordModel *reviewWordModel = [LGTodayReviewWordModel mj_objectWithKeyValues:response];
				self.ebbinghausReviewWordIdArray = reviewWordModel.wordsId;
				[self pushNextWordDetailController:LGwordDetailTodayEbbinghausReview animated:NO];
			}
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
//		[self isNormal:error];
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
	[[LGPlayer sharedPlayer] playWithAudioType:LGAudio_familiar];
	[self updateWordStatus:LGWordStatusFamiliar];
}

//认识
- (IBAction)knowAction:(id)sender {
	[[LGPlayer sharedPlayer] playWithAudioType:LGAudio_know];
	[self updateWordStatus:LGWordStatusKnow];
}

//不认识
- (IBAction)notKnowAction:(id)sender {
	[[LGPlayer sharedPlayer] playWithAudioType:LGAudio_estimate_notKnow];
	[self updateWordStatus:LGWordStatusIncognizance];
}

// 在背单词模式下标记为模糊,其他复习模式下标记为忘记
- (IBAction)vagueOrForgotAction:(id)sender {
	
	if (self.controllerType == LGWordDetailReciteWords) {
		[[LGPlayer sharedPlayer] playWithAudioType:LGAudio_dim];
	}else{
		[[LGPlayer sharedPlayer] playWithAudioType:LGAudio_forget];
	}
	
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
			
		case LGwordDetailTodayEbbinghausReview:
			[self updateEbbinghausReviewWordStatus:status];
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
 当复习id列表为空时,如果是背单词的艾宾浩斯模式(LGWordDetailEbbinghausReview)进入背单词模式(LGWordDetailReciteWords),
 如果是今日复习的艾宾浩斯(LGwordDetailTodayEbbinghausReview)则弹出分享框
 
 @param status 单词状态
 */
- (void)updateEbbinghausReviewWordStatus:(LGWordStatus) status {
	[LGProgressHUD showHUDAddedTo:self.view];
	
	NSInteger type = self.controllerType == LGWordDetailEbbinghausReview ? 1 : 0;
	
	[self.request updateReviewWordStatus:status wordId:self.detailModel.words.ID type:type completion:^(id response, LGError *error) {
		if ([self isNormal:error]) {
			NSString *wordID = self.ebbinghausReviewWordIdArray.firstObject;
			[self.ebbinghausReviewWordIdArray removeObjectAtIndex:0];
			if (status != LGWordStatusKnow && status != LGWordStatusFamiliar) {
				[self.ebbinghausReviewWordIdArray addObject:wordID];
			}
			
			//今日复习艾宾浩斯
			if (self.controllerType == LGwordDetailTodayEbbinghausReview)
				{
				if (self.ebbinghausReviewWordIdArray.count == 0) {
					[self performSegueWithIdentifier:@"wordDetailToShare" sender:nil];
				}else{
					[self pushNextWordDetailController:LGwordDetailTodayEbbinghausReview animated:YES];
				}
				
				//正常背单词艾宾浩斯
			}else if(self.controllerType == LGWordDetailEbbinghausReview){
				
				// 新艾宾浩斯结束
				if (self.ebbinghausReviewWordIdArray.count == 0) {
					[self.request finishEbbinghausCompletion:^(id response, LGError *error) {
						if ([self isNormal:error]) {
							[self pushNextWordDetailController:LGWordDetailReciteWords  animated:YES];
						}
					}];
				}else{
					[self pushNextWordDetailController:LGWordDetailEbbinghausReview  animated:YES];
				}
			}
		}
	}];
}

/**
 复习模式下修改单词状态,并跳转到下一个单词
 
 @param status 单词状态
 */
- (void)updateReviewWordStatus:(LGWordStatus) status {
	[LGProgressHUD showHUDAddedTo:self.view];
	NSInteger type = self.controllerType == LGWordDetailEbbinghausReview ? 1 : 0;
	[self.request updateReviewWordStatus:status wordId:self.detailModel.words.ID type:type completion:^(id response, LGError *error) {
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
	
	
	//在"错题本复习/时间复习" 模式下,当当前进度等于总进度时.弹出复习完成框
	if ((self.controllerType == LGWordDetailReview)  && self.reviewWordIdArray.count == 0) {
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
		wordDetailController.reviewTyep = self.reviewTyep;
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
			
            [cell setQuestion:dataSource.cellContent[0] word:self.detailModel.words.word article:self.detailModel.question.article  completion:^{
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
