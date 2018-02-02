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

@interface LGWordPlanController () <UITableViewDataSource, UITableViewDelegate,UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation LGWordPlanController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[self performSegueWithIdentifier:@"myPlanTowordLibrary" sender:nil];
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
		if ([weakSelf isNormal:error]) {
			
		}
	}];
}


/**
 编辑词包
 */
- (IBAction)editAction:(UIButton *)sender {
	
}

#pragma mark -UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	LGPlanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LGPlanTableViewCell"];
	
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


#pragma mark - UICollectionViewDelegate



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}


@end
