//
//  LGWordPlanController.m
//  Word
//
//  Created by Charles Cao on 2018/1/30.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGWordPlanController.h"
#import "UIScrollView+LGRefresh.h"
#import "LGPlanTableViewCell.h"
#import "LGWordPlanCollectionCell.h"

@interface LGWordPlanController () <UITableViewDataSource, UITableViewDelegate,UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSMutableArray<LGPlanModel *> *planArray;
@property (nonatomic, strong) LGPlanModel *selectedPlan;

@end

@implementation LGWordPlanController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self performSegueWithIdentifier:@"myPlanTowordLibrary" sender:nil];
    //  [self configUserInterface];
    
    
}

//进入界面刷新,self.planArray 为nil, 表示第一次进入界面,需要显示 loading
- (void)viewDidAppear:(BOOL)animated{
     [self requestData:self.planArray == nil];
}

- (void)requestData:(BOOL)isShowLoading {
    if (isShowLoading) [LGProgressHUD showHUDAddedTo:self.view];
    __weak typeof(self) weakSelf = self;
    [self.request requestUserPlan:^(id response, LGError *error) {
        [weakSelf.scrollView lg_endRefreshing];
        if ([weakSelf isNormal:error]) {
            weakSelf.planArray = [LGPlanModel mj_objectArrayWithKeyValuesArray:response[@"package"]];
            [weakSelf.collectionView reloadData];
            [weakSelf.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
            weakSelf.selectedPlan = weakSelf.planArray.firstObject;
            
        }
    }];
}


/**
 编辑词包
 */
- (IBAction)editAction:(UIButton *)sender {
    
}

- (void)setSelectedPlan:(LGPlanModel *)selectedPlan{
    _selectedPlan = selectedPlan;
    [self.dayTable reloadData];
    [self.numberTable reloadData];
    if (StringNotEmpty(_selectedPlan.planDay)) {
        
    }
}

#pragma mark -UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.selectedPlan.total.integerValue - self.selectedPlan.userWords.integerValue;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LGPlanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LGPlanTableViewCell"];
    cell.num = tableView == self.dayTable ? indexPath.row + 1 : [tableView numberOfRowsInSection:0] - indexPath.row;
    return cell;
}

#pragma mark - UITableViewDelegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    LGPlanTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (tableView == self.dayTable) {
        self.dayLabel.text = [NSString stringWithFormat:@"%ld天",cell.num];
        self.
    }else{
        self.numberLabel.text = [NSString stringWithFormat:@"%ld个",cell.num];
    }
}

#pragma mark - UIScrollViewDelegate

// 滚动视图减速完成，滚动将停止时，调用该方法。一次有效滑动，只执行一次。

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    if ([scrollView isKindOfClass:[LGPlanTableView class]] && !decelerate) {
        [self fixSelectCellOfTable:(LGPlanTableView *)scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if ([scrollView isKindOfClass:[LGPlanTableView class]]) {
        [self fixSelectCellOfTable:(LGPlanTableView *)scrollView];
    }
}


/**
 调整cell到高亮区域
 判断高亮区域的中心点在哪个cell中
 */
- (void)fixSelectCellOfTable:(LGPlanTableView *)tableView{
    
    CGPoint selectedViewCenter = CGPointMake(0, CGRectGetMidY(tableView.selectedCellBackgroundView.bounds));
    CGPoint convertPoint = [tableView.selectedCellBackgroundView convertPoint:selectedViewCenter toView:tableView];
    NSIndexPath *indexPath = [tableView indexPathForRowAtPoint:convertPoint];
    if (indexPath) {
        [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        if ([tableView.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
            [tableView.delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
        }
    }
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.planArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LGWordPlanCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LGWordPlanCollectionCell" forIndexPath:indexPath];
    cell.planModel = self.planArray[indexPath.row];
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
    [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}


@end

@implementation LGPlanTableView

//布局完，设置中间高亮区域
- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.backgroundView && self.selectedCellBackgroundView) {
        return;
    }
    self.tableFooterView = [UIView new];
    CGFloat edge = (self.frame.size.height - self.rowHeight) / 2.0f;
    self.contentInset = UIEdgeInsetsMake(edge, 0, edge, 0);
    self.backgroundView = [[UIView alloc]init];
    self.selectedCellBackgroundView = [[UIView alloc]init];
    //设置居中
    self.selectedCellBackgroundView.frame = CGRectMake(0, self.frame.size.height/2.0 - self.rowHeight / 2.0 , self.frame.size.width, self.rowHeight);
    self.selectedCellBackgroundView.backgroundColor = [UIColor lg_colorWithHexString:@"e7e5e5"];
    [self.backgroundView addSubview:self.selectedCellBackgroundView];
}

@end


