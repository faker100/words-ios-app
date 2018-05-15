//
//  LGWordLibraryController.m
//  Word
//
//  Created by Charles Cao on 2018/1/30.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGWordLibraryController.h"
#import "LGWordLibraryTypeCell.h"
#import "LGWordTypeCell.h"
#import "LGWordLibraryModel.h"
#import "UIScrollView+LGRefresh.h"
#import "LGFreeLibraryWordListController.h"

@interface LGWordLibraryController () <UITableViewDelegate,UITableViewDataSource>

//词库列表
@property (nonatomic, strong) NSArray<LGWordLibraryModel *> *modelArray;

//选中的词库 默认第一个
@property (nonatomic, strong) LGWordLibraryModel *selectedModel;

@end

@implementation LGWordLibraryController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.libraryTableView.tableFooterView = [UIView new];
	self.wordTypeTableView.tableFooterView = [UIView new];
	[self requestData];
}

- (void)requestData{
	
	[LGProgressHUD showHUDAddedTo:self.view];
	[self.request requestWordLibraryList:^(id response, LGError *error) {
		[LGProgressHUD hideHUDForView:self.view];
        if ([self isNormal:error]) {
			self.modelArray = [LGWordLibraryModel mj_objectArrayWithKeyValuesArray:response[@"package"]];
			self.selectedModel = self.modelArray.firstObject;
			[self.libraryTableView reloadData];
			[self.wordTypeTableView reloadData];
			[self.libraryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
		}
	}];
}

- (void)setSelectedModel:(LGWordLibraryModel *)selectedModel{
	_selectedModel = selectedModel;
	[self.wordTypeTableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return tableView == self.libraryTableView ? self.modelArray.count : self.selectedModel.child.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (tableView == self.libraryTableView) {
		LGWordLibraryTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LGWordLibraryTypeCell"];
		cell.wordLibrary = self.modelArray[indexPath.row];
		return cell;
	}else {
		LGWordTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LGWordTypeCell"];
		cell.wordTypeModel = self.selectedModel.child[indexPath.row];
		return cell;
	}
}

#pragma mark -UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (tableView == self.libraryTableView) {
		self.selectedModel = self.modelArray[indexPath.row];
	}else{
		[self performSegueWithIdentifier:@"WordLibraryToWordList" sender:self.selectedModel.child[indexPath.row]];
		[tableView deselectRowAtIndexPath:indexPath animated:YES];
	}
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"WordLibraryToWordList"]) {
        LGFreeLibraryWordListController *controller = segue.destinationViewController;
        controller.wordLibraryModel = sender;
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
