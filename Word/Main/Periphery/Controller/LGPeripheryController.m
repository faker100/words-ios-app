//
//  LGPeripheryController.m
//  Word
//
//  Created by Charles Cao on 2018/4/8.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGPeripheryController.h"
#import "LGPeripheryModel.h"
#import "UIScrollView+LGRefresh.h"
#import "LGPublicCourseCollectionCell.h"
#import "LGPeripheryLiveCell.h"
#import "LGPeripherySectionHeader.h"
#import "LGClassicCourseCell.h"
#import "LGPeripheryCaseCell.h"

@interface LGPeripheryController ()<UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) LGPeripheryModel *peripheryModel;

@end

@implementation LGPeripheryController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	[self configUI];
	[self requestData];
	
	[self.request requestCourseListWithType:LGCourseGMAT completion:^(id response, LGError *error) {
		if ([self isNormal:error]) {
			
		}
	}];
	
}

- (void)configUI{
	[self.tableView registerNib:[UINib nibWithNibName:@"LGPeripherySectionHeader" bundle:nil] forHeaderFooterViewReuseIdentifier:@"LGPeripherySectionHeader"];
	__weak typeof(self) weakSelf = self;
	[self.tableView setHeaderRefresh:^{
		[weakSelf requestData];
	}];
	
	UICollectionViewFlowLayout  *flowLayout = (UICollectionViewFlowLayout *)self.publicCollectionView.collectionViewLayout;
	flowLayout.minimumLineSpacing = 0;
	flowLayout.minimumInteritemSpacing = 0;
	//最近公开课比例
	flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH, 90.0 / 375 * SCREEN_WIDTH);
	
	//tableHeaderView 高度相应变化, 375宽度的屏幕下,tableheader高度是400,公开课 colletion 高度为90
	self.tableView.tableHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 400 + (flowLayout.itemSize.height - 90));
}

- (void)requestData{
	[self.request requestRimCompletion:^(id response, LGError *error) {
		[self.tableView lg_endRefreshing];
		if ([self isNormal:error]) {
			self.peripheryModel = [LGPeripheryModel mj_objectWithKeyValues:response];
		}
	}];
}

- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	[self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidLayoutSubviews{
	self.tableView.contentOffset = CGPointZero;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
- (void)setPeripheryModel:(LGPeripheryModel *)peripheryModel{
	_peripheryModel = peripheryModel;
	[self.publicCollectionView reloadData];
	[self.tableView reloadData];
}


#pragma mark -UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if (section == 2) {
		return self.peripheryModel.aCase.count;
	}else{
		return 1;
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == 0) {
        LGPeripheryLiveCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LGPeripheryLiveCell"];
        cell.livePreview = self.peripheryModel.livePreview;
        return cell;
	}else if (indexPath.section == 1){
        LGClassicCourseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LGClassicCourseCell"];
        cell.choiceness = self.peripheryModel.choiceness;
        return cell;
	}else{
        LGPeripheryCaseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LGPeripheryCaseCell"];
        cell.caseModel = self.peripheryModel.aCase[indexPath.row];
        return cell;
	}
}

#pragma mark -UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == 0) {
		return 348;
    }else if (indexPath.section == 1){
        //在375屏幕下，cell高度为 320，等比例换算其他屏幕下的尺寸
        return  320.0 / 375.0 * SCREEN_WIDTH;
    }else{
        return 44;
    }
	
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    LGPeripherySectionHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LGPeripherySectionHeader"];
    if (section == 0) {
        header.type = LGPeripherySectionLive;
    }else if(section == 1){
        header.type = LGPeripherySectionClassic;
    }else{
        header.type = LGPeripherySectionCase;
    }
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 12;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
	return self.peripheryModel.recentClass.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	LGPublicCourseCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LGPublicCourseCollectionCell" forIndexPath:indexPath];
	cell.classModel = self.peripheryModel.recentClass[indexPath.row];
	return cell;
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
