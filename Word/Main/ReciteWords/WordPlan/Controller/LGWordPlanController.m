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

@end

@implementation LGWordPlanController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	//[self performSegueWithIdentifier:@"myPlanTowordLibrary" sender:nil];
  //  [self configUserInterface];
	
	
}

//进入界面刷新,self.planArray 为nil, 表示第一次进入界面,需要显示 loading
- (void)viewWillAppear:(BOOL)animated{
	[self requestData:self.planArray == nil];
}

- (void)viewDidLayoutSubviews {
	[self configTable:self.numberTable];
//	[self configTable:self.dayTable];
}

- (void)configTable:(UITableView *)tableView {
	
	tableView.backgroundView = [[UIView alloc]init];
	UIView *selectedCellBackgroundView = [[UIView alloc]init];
	//设置居中
	selectedCellBackgroundView.frame = CGRectMake(0, tableView.frame.size.height/2.0 - tableView.rowHeight / 2.0 , self.dayTable.frame.size.width, tableView.rowHeight);
	//selectedCellBackgroundView.frame = CGRectMake(0, 0, self.dayTable.frame.size.width, tableView.rowHeight);
	//selectedCellBackgroundView.center = tableView.center;
	selectedCellBackgroundView.backgroundColor = [UIColor lg_colorWithHexString:@"e7e5e5"];

	[tableView.backgroundView addSubview:selectedCellBackgroundView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)requestData:(BOOL)isShowLoading {
	if (isShowLoading) [LGProgressHUD showHUDAddedTo:self.view];
	__weak typeof(self) weakSelf = self;
	[self.request requestUserPlan:^(id response, LGError *error) {
        [weakSelf.scrollView lg_endRefreshing];
		if ([weakSelf isNormal:error]) {
			self.planArray = [LGPlanModel mj_objectArrayWithKeyValuesArray:response[@"package"]];
            [weakSelf.collectionView reloadData];
		}
	}];
}


/**
 编辑词包
 */
- (IBAction)editAction:(UIButton *)sender {
	
}

#pragma mark -UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	LGPlanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LGPlanTableViewCell"];
    cell.num = indexPath.row;
	return cell;
}

#pragma mark -UITableViewDelegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
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



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}


@end

