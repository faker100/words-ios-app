//
//  LGAddPlanController.m
//  Word
//
//  Created by Charles Cao on 2018/4/27.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGAddPlanController.h"
#import "LGPlanTableViewCell.h"

@interface LGAddPlanController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) NSInteger planDay;    //计划天数
@property (nonatomic, assign) NSInteger planWords;  //计划个数

@end

@implementation LGAddPlanController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    [self configUserInterface];
}

- (void)configUserInterface{
	self.packageLabel.text = [NSString stringWithFormat:@"%@ (%@个词)",self.libModel.name, self.libModel.total] ;
	
	//初始化计划选择
	[self setPlanWithType:LGChooseDayPlan value:5 isFixOther:YES];
}

- (void)setPlanDay:(NSInteger)planDay{
	_planDay = planDay;
	[self updatePlanAttributeText];
}

- (void)setPlanWords:(NSInteger)planWords{
	_planWords = planWords;
	[self updatePlanAttributeText];
}

//更新计划文字
- (void)updatePlanAttributeText{
	NSString *str = [NSString stringWithFormat:@"我计划  %ld  天,每天背  %ld  个单词",self.planDay,self.planWords];
	NSRange planDayRnage = [str rangeOfString:[NSString stringWithFormat:@"  %ld  ",self.planDay]];
	NSRange planWordsRnage = [str rangeOfString:[NSString stringWithFormat:@"  %ld  ",self.planWords]];
	
	NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:str];
	[attStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, attStr.length)];
	[attStr addAttribute:NSForegroundColorAttributeName value:[UIColor lg_colorWithType:LGColor_Title_2_Color] range:NSMakeRange(0, attStr.length)];
	[attStr addAttribute:NSForegroundColorAttributeName value:[UIColor lg_colorWithType:LGColor_Title_1_Color] range:planDayRnage];
	[attStr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:planDayRnage];
	[attStr addAttribute:NSForegroundColorAttributeName value:[UIColor lg_colorWithType:LGColor_Title_1_Color] range:planWordsRnage];
	[attStr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:planWordsRnage];
	self.planLabel.attributedText = attStr;
}

- (IBAction)addPlanAction:(UIButton *)sender {
    [LGProgressHUD showHUDAddedTo:self.view];
    __weak typeof(self) weakSelf = self;
    [self.request addWordLibrary:self.libModel.ID planDay:self.planDay planWord:self.planWords  completion:^(id response, LGError *error) {
        if ([weakSelf isNormal:error]) {
            [LGProgressHUD showSuccess:@"添加成功" toView:weakSelf.view completionBlock:^{
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }];
        }
    }];
}


#pragma mark -UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.libModel.total.integerValue;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	LGPlanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LGPlanTableViewCell"];
	cell.num = tableView == self.dayTable ? indexPath.row + 1 : [tableView numberOfRowsInSection:0] - indexPath.row;
	return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	LGPlanTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	[self setPlanWithType:((LGPlanTableView *)tableView).planType value:cell.num isFixOther:YES];
}

#pragma mark -
/**
 设置选择的计划
 
 @param type 计划类型
 @param value 选择计划的值
 @param flag 是否根据当前选择计划(天数/个数),修改另一个计划(个数/天数)
 */
- (void)setPlanWithType:(LGChoosePlanType)type value:(NSInteger)value isFixOther:(BOOL)flag{
	
	value = MAX(value, 1);
	if (type == LGChooseDayPlan) {
		self.dayLabel.text = [NSString stringWithFormat:@"%ld天",value];
		self.planDay = value;
		NSIndexPath *indexPath = [NSIndexPath indexPathForRow:value - 1 inSection:0];
		
		[self.dayTable selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
		
		
		if (flag) {
			NSInteger otherValue = ceil(self.libModel.total.floatValue / value);
			[self setPlanWithType:LGChooseNumPlan value:otherValue isFixOther:NO];
		}
	}else{
		self.numberLabel.text = [NSString stringWithFormat:@"%ld个",value];
		self.planWords = value;
		NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.libModel.total.floatValue - value inSection:0];
		
		[self.numberTable selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
		
		
		if (flag) {
			NSInteger otherValue = ceil(self.libModel.total.floatValue * 1.0 / value);
			[self setPlanWithType:LGChooseDayPlan value:otherValue isFixOther:NO];
		}
	}
}

/**
 滑动最近或者选中cell到中间高亮区域
 判断高亮区域的中心点在哪个cell中
 */
- (void)scrollSelectCellToMiddleOfTable:(LGPlanTableView *)tableView{
	CGPoint selectedViewCenter = CGPointMake(0, CGRectGetMidY(tableView.selectedCellBackgroundView.bounds));
	CGPoint convertPoint = [tableView.selectedCellBackgroundView convertPoint:selectedViewCenter toView:tableView];
	NSIndexPath *indexPath = [tableView indexPathForRowAtPoint:convertPoint];
	if (indexPath) {
		NSInteger value = ((LGPlanTableViewCell *)[tableView cellForRowAtIndexPath:indexPath]).num;
		[self setPlanWithType:tableView.planType value:value isFixOther:YES];
	}
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	if ([scrollView isKindOfClass:[LGPlanTableView class]] && !decelerate) {
		[self scrollSelectCellToMiddleOfTable:(LGPlanTableView *)scrollView];
	}
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
	if ([scrollView isKindOfClass:[LGPlanTableView class]]) {
		[self scrollSelectCellToMiddleOfTable:(LGPlanTableView *)scrollView];
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
