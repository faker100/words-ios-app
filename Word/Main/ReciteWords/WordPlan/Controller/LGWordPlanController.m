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
    [self configUserInterface];
	[self requestData:YES];
}

- (void)configUserInterface{
    
	__weak typeof(self) weakSelf = self;
	[self.scrollView setHeaderRefresh:^{
		[weakSelf requestData:NO];
	}];
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
            self.planArray = [LGPlanModel mj_objectArrayWithKeyValuesArray:response];
            [self.collectionView reloadData];
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

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
	return 0;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LGWordPlanCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LGWordPlanCollectionCell" forIndexPath:indexPath];
    cell.planModel = self.planArray[indexPath.row];
    return cell;
}

#pragma mark - UICollectionViewDelegate



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}


@end
