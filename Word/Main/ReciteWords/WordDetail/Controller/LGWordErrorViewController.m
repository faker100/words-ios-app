//
//  LGWordErrorViewController.m
//  Word
//
//  Created by Charles Cao on 2018/2/23.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGWordErrorViewController.h"
#import "LGWordErrorCell.h"

NSString *const placeholder = @"请输入题目纠错信息";

@interface LGWordErrorViewController () <UITableViewDelegate, UITableViewDataSource, UITextViewDelegate>

@end

@implementation LGWordErrorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.textView.text = placeholder;
	self.tableView.tableFooterView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 250);
	[self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submitAction:(UIButton *)sender {
	
	if (!StringNotEmpty(self.wordID)) {
		[LGProgressHUD showError:@"缺少单词 id " toView:self.view];
		return;
	}
	
	NSInteger selectedType = [self.tableView indexPathForSelectedRow].row + 1;
	[self.request submitWordErrorWithType:selectedType content:self.textView.text wordId:self.wordID completion:^(id response, LGError *error) {
		if ([self isNormal:error]) {
			[LGProgressHUD showSuccess:@"提交成功" toView: self.view completionBlock:^{
				[self.navigationController popViewControllerAnimated:YES];
			}];
		}
	}];
}

- (IBAction)cancelAction:(UIButton *)sender {
	[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	LGWordErrorCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LGWordErrorCell"];
	if (indexPath.row == 0) 	 cell.errorTitleLabel.text = @"单词拼写错误";
	else if (indexPath.row == 1) cell.errorTitleLabel.text = @"格式有错误";
	else if (indexPath.row == 2) cell.errorTitleLabel.text = @"翻译错误";
	else if (indexPath.row == 3) cell.errorTitleLabel.text = @"其他";
	return cell;
}

#pragma mark - UITextViewDelegate

- (void)textViewDidEndEditing:(UITextView *)textView{
	if (textView.text.length == 0) {
		textView.text = placeholder;
	}
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
	if ([textView.text isEqualToString:placeholder]) {
		textView.text = @"";
	}
}

@end
