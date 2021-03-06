//
//  LGWordPlanController.m
//  Word
//
//  Created by Charles Cao on 2018/1/30.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGWordPlanController.h"
#import "LGPlanTableViewCell.h"
#import "LGWordPlanCollectionCell.h"
#import "LGDeletePlanAlertView.h"

@interface LGWordPlanController () <UITableViewDataSource, UITableViewDelegate,UICollectionViewDelegate, UICollectionViewDataSource, LGWordPlanCollectionCellDelegate>

@property (nonatomic, strong) NSMutableArray<LGPlanModel *> *planArray;
@property (nonatomic, strong) LGPlanModel *selectedPlan;
@property (nonatomic, strong) NSString *nowPackageId; //当前学习中的 id

@end

@implementation LGWordPlanController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

//进入界面刷新,self.planArray 为nil, 表示第一次进入界面,需要显示 loading
- (void)viewDidAppear:(BOOL)animated{
     [self requestData:self.planArray == nil];
}

- (void)requestData:(BOOL)isShowLoading {
    if (isShowLoading) [LGProgressHUD showHUDAddedTo:self.view];
    __weak typeof(self) weakSelf = self;
    [self.request requestUserPlan:^(id response, LGError *error) {
        if ([weakSelf isNormal:error]) {
            weakSelf.planArray = [LGPlanModel mj_objectArrayWithKeyValuesArray:response[@"package"]];
			weakSelf.nowPackageId = [NSString stringWithFormat:@"%@",response[@"nowPackage"]];
            [weakSelf.collectionView reloadData];
			
			[weakSelf.planArray enumerateObjectsUsingBlock:^(LGPlanModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
				if ([weakSelf.nowPackageId isEqualToString:obj.catId]) {
					[weakSelf.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:idx inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
					weakSelf.selectedPlan = obj;
				}
			}];
        }
    }];
}

/**
 编辑词包
 */
- (IBAction)editAction:(UIButton *)sender {
	sender.selected = !sender.isSelected;
	[self.collectionView reloadData];
	
	//reloadData 会取消选中状态,重新赋值
	self.selectedPlan = self.selectedPlan;
}


/**
 修改计划
 
 */
- (IBAction)uploadPlanAction:(id)sender {
	
	if (self.planArray.count == 0) {
		[self.navigationController popViewControllerAnimated:YES];
	}else{
		__weak typeof(self) weakSelf = self;
		[LGProgressHUD showHUDAddedTo:self.view];
		[self.request uploadWordLibraryArray:self.planArray completion:^(id response, LGError *error) {
			if ([weakSelf isNormal:error]) {
				[LGProgressHUD showSuccess:@"修改成功" toView:weakSelf.view  completionBlock:^{
					[weakSelf.navigationController popViewControllerAnimated:YES];
				}];
			}
		}];
	}
}


/**
 设置选中的计划,并滚动到视图中间

 @param selectedPlan 选中的计划
 */
- (void)setSelectedPlan:(LGPlanModel *)selectedPlan{
    _selectedPlan = selectedPlan;
    [self.dayTable reloadData];
    [self.numberTable reloadData];
	if (selectedPlan) {
		NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.planArray indexOfObject:selectedPlan] inSection:0];
		[self.collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
		[self setPlanWithType:LGChooseDayPlan value:_selectedPlan.planDay.integerValue isFixOther:YES];
	}else{
		self.dayLabel.text = @"0天";
		self.numberLabel.text = @"0天";
	}
}

//设置为学习中的词包
- (void)updateNowPackage:(NSString *)catId{
	if ([catId isEqualToString:self.nowPackageId]) {
		return;
	}
	self.nowPackageId = catId;
    [self.request updateNowPackage:self.nowPackageId completion:^(id response, LGError *error) {
        if ([self isNormal:error]) {
            
        }
    }];
	[self.collectionView reloadData];
}

#pragma mark -UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.selectedPlan.total.integerValue;
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


#pragma mark -

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



/**
 设置选择的计划

 @param type 计划类型
 @param value 选择计划的值
 @param flag 是否根据当前选择计划(天数/个数),修改另一个计划(个数/天数)
 */
- (void)setPlanWithType:(LGChoosePlanType)type value:(NSInteger)value isFixOther:(BOOL)flag{
    
    //所选词包没有剩余单词时，返回
    if (self.selectedPlan.total.integerValue == 0) {
        self.dayLabel.text = @"0天";
        self.numberLabel.text = @"0个";
        return;
    }
	 value = MAX(value, 1);
	if (type == LGChooseDayPlan) {
		self.dayLabel.text = [NSString stringWithFormat:@"%ld天",value];
		self.selectedPlan.planDay = @(value).stringValue;
		NSIndexPath *indexPath = [NSIndexPath indexPathForRow:value - 1 inSection:0];
        
        [self.dayTable selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        
		
		if (flag) {
			NSInteger otherValue = ceil(self.selectedPlan.total.integerValue * 1.0 / value);
			[self setPlanWithType:LGChooseNumPlan value:otherValue isFixOther:NO];
		}
	}else{
		self.numberLabel.text = [NSString stringWithFormat:@"%ld个",value];
		self.selectedPlan.planWords = @(value).stringValue;
		NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.selectedPlan.total.integerValue - value inSection:0];
        
        [self.numberTable selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        
		
		if (flag) {
			NSInteger otherValue = ceil(self.selectedPlan.total.integerValue * 1.0 / value);
			[self setPlanWithType:LGChooseDayPlan value:otherValue isFixOther:NO];
		}
	}
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.planArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LGWordPlanCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LGWordPlanCollectionCell" forIndexPath:indexPath];
	cell.delegate = self;
    cell.planModel = self.planArray[indexPath.row];
	cell.isEdit = self.editButton.isSelected;
	cell.learningImageView.hidden = ![self.planArray[indexPath.row].catId isEqualToString:self.nowPackageId];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LGCollectionHeaderView" forIndexPath:indexPath];
        return  header;
    }else{
        UICollectionReusableView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"LGCollectionFooterView" forIndexPath:indexPath];
        footerview.backgroundColor = [UIColor purpleColor];
        return footerview;
    }
}

#pragma mark - UICollectionViewDelegate


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
	[self updateNowPackage:self.planArray[indexPath.row].catId];
    self.selectedPlan = self.planArray[indexPath.row];
	
}

#pragma mark - LGWordPlanCollectionCellDelegate


/**
 删除计划, 如果删除的是学习中的词包,则设置删除后第一个词包为学习中
 */
- (void)deletePlan:(LGPlanModel *)planModel{
	
	LGDeletePlanAlertView *deletePlanAlertView = [[NSBundle mainBundle]loadNibNamed:@"LGDeletePlanAlertView" owner:nil options:nil].firstObject;
	deletePlanAlertView.titleLabel.text = [NSString stringWithFormat:@"确定删除%@的%@个单词?",planModel.name,planModel.total];
	__weak typeof(deletePlanAlertView) weakView = deletePlanAlertView;
	__weak typeof(self) weakSelf = self;
	__weak typeof(planModel) weakPlanModel = planModel;
	deletePlanAlertView.deleteBlock = ^{
		[LGProgressHUD showHUDAddedTo:weakView];
		[weakSelf.request deleteWordLibrary:weakPlanModel.ID completion:^(id response, LGError *error) {
			if ([weakSelf isNormal:error]) {
				NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[weakSelf.planArray indexOfObject:weakPlanModel] inSection:0];
				
				[weakSelf.planArray removeObject:weakPlanModel];
				[weakSelf.collectionView deleteItemsAtIndexPaths:@[indexPath]];
				if (weakPlanModel == weakSelf.selectedPlan) {
					weakSelf.selectedPlan = nil;
				}
				
				//如果删除的是学习中的词包,则设置删除后数组的第一个词包为学习中
				if ([weakPlanModel.catId isEqualToString:weakSelf.nowPackageId] && weakSelf.planArray.count > 0) {
					weakSelf.nowPackageId = weakSelf.planArray.firstObject.catId;
					//刷新第一个 cell
					[weakSelf.collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]]];
				}
				[LGProgressHUD showSuccess:@"删除成功" toView:weakSelf.view];
				
				[weakView removeFromSuperview];
			}
		}];
	};
	UIWindow *window = self.view.window;
	deletePlanAlertView.frame = window.bounds;
	[window addSubview:deletePlanAlertView];
}



@end


