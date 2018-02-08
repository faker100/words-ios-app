//
//  LGWordDetailController.m
//  Word
//
//  Created by Charles Cao on 2018/2/7.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGWordDetailController.h"
#import "LGWordDetailModel.h"
#import "LGWordDetailCell.h"
#import "LGWordDetailHeaderFooterView.h"
#import "LGPlayer.h"

@interface LGWordDetailController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) LGWordDetailModel *detailModel;

@end

@implementation LGWordDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	[self requestData];
	
	[self.wordTabelView registerNib:[UINib nibWithNibName:@"LGWordDetailHeaderFooterView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"LGWordDetailHeaderFooterView"];
}

- (void)configInterface{
	self.wordLabel.text = self.detailModel.words.word;
	[self.playerButton setTitle:[NSString stringWithFormat:@"  %@",self.detailModel.words.phonetic_us] forState:UIControlStateNormal];
	[self.wordTabelView reloadData];
}

-(void)requestData {
	[LGProgressHUD showHUDAddedTo:self.view];
	[self.request requestReciteWordsCompletion:^(id response, LGError *error) {
		if ([self isNormal:error]) {
			self.detailModel = [LGWordDetailModel mj_objectWithKeyValues:response];
			[self configInterface];
		}
	}];
}



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
//报错
- (IBAction)reportErrorsAction:(id)sender {
}

//熟识
- (IBAction)familiarAction:(id)sender {
}

//认识
- (IBAction)knowAction:(id)sender {
}

//不认识
- (IBAction)notKnowAction:(id)sender {
}

//模糊
- (IBAction)vagueAction:(id)sender {
}

#pragma mark -UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return self.detailModel.dataSource.count;
	//return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	
	return self.detailModel.dataSource[section].cellContent.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (tableView == self.wordTabelView) {
		LGWordDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LGWordDetailCell"];
		cell.contentLabel.text = self.detailModel.dataSource[indexPath.section].cellContent[indexPath.row];
		return cell;
	}
	return nil;
}

#pragma mark -UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
	LGWordDetailHeaderFooterView *heaerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LGWordDetailHeaderFooterView"];
	heaerView.titleLabel.text = self.detailModel.dataSource[section].sectionTitle;
	return heaerView;
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
