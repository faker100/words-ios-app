//
//  LGFreeLibraryWordListController.m
//  Word
//
//  Created by caoguochi on 2018/1/31.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGFreeLibraryWordListController.h"
#import "UITableView+LGRefresh.h"
#import "LGFreeWordListCell.h"
#import "LGPlayer.h"

@interface LGFreeLibraryWordListController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray<LGFreeWordModel *> *modelArray;

@end

@implementation LGFreeLibraryWordListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configUserInterface];
    [self requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)configUserInterface{
	self.modelArray = [NSMutableArray array];
	self.title = self.wordLibraryModel.name;
	self.tableView.tableHeaderView.frame = CGRectMake(0, 0, self.view.frame.size.width, 36);
	self.wordNumberLabel.attributedText = [self getWordNumAttribute];
	__weak typeof(self) weakSelf = self;
	[self.tableView setRefreshBlock:^(LGCurrentRefreshType type) {
		[weakSelf requestData];
	}];
}

- (NSAttributedString *)getWordNumAttribute{
	NSString *wordNumStr = @"单词量: ";
	NSString *userWords = self.wordLibraryModel.userWords;
	NSString *totalWords = self.wordLibraryModel.total;
	NSString *str = [NSString stringWithFormat:@"%@%@/%@",wordNumStr,userWords,totalWords];
	NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc]initWithString:str];
	[attribute addAttribute:NSFontAttributeName value:self.wordNumberLabel.font range:NSMakeRange(0, str.length)];
	[attribute addAttribute:NSForegroundColorAttributeName value:self.wordNumberLabel.textColor range:NSMakeRange(0, str.length)];
	[attribute addAttribute:NSForegroundColorAttributeName value:[UIColor lg_colorWithType:LGColor_theme_Color] range:NSMakeRange(wordNumStr.length, userWords.length)];
	return attribute;
}

- (void)requestData {
	
	[self.request requestFreeLibraryWordList:self.wordLibraryModel.ID page:self.tableView.currentPage completion:^(id response, LGError *error) {
		[self.tableView lg_endRefreshing];
		if (error) {
			[LGProgressHUD showError:error.errorMessage toView:self.view];
			return ;
		}
		NSArray *newModelArray = [LGFreeWordModel mj_objectArrayWithKeyValuesArray:response[@"packageDetails"]];
		if (self.tableView.currentPage == 1) {
			[self.modelArray setArray:newModelArray];
			[self.tableView reloadData];
		}else{
			[self.modelArray addObjectsFromArray:newModelArray];
			[self.tableView addMoreDataWithType:LGTableReloadOnlyAddSection newModelArray:newModelArray];
		}
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.modelArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	LGFreeWordListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LGFreeWordListCell"];
	cell.wordModel = self.modelArray[indexPath.section];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
	LGFreeWordModel *wordModel = self.modelArray[indexPath.section];
	if (StringNotEmpty(wordModel.us_audio)) {
		[[LGPlayer sharedPlayer] playWithUrl:wordModel.us_audio];
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
