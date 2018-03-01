//
//  LGIndexReviewAlertView.m
//  Word
//
//  Created by Charles Cao on 2018/2/24.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGIndexReviewAlertView.h"
#import "LGIndexReviewAlertCell.h"

@implementation LGIndexReviewAlertView

- (void)awakeFromNib{
	[super awakeFromNib];
	[self.tableView registerNib:[UINib nibWithNibName:@"LGIndexReviewAlertCell" bundle:nil] forCellReuseIdentifier:@"LGIndexReviewAlertCell"];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setReviewModel:(LGIndexReviewModel *)reviewModel{
	_reviewModel = reviewModel;
	
	NSString *tempStr= [[NSString alloc]initWithFormat:@"%@ 词",reviewModel.all];
	NSMutableAttributedString *attributeStr =[[NSMutableAttributedString alloc]initWithString:tempStr];
	[attributeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:22] range:NSMakeRange(0, reviewModel.all.length)];
	[attributeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(tempStr.length - 1, 1)];
	[attributeStr addAttribute:NSForegroundColorAttributeName value:[UIColor lg_colorWithType:LGColor_theme_Color] range:NSMakeRange(tempStr.length - 1, 1)];
	
	self.countLabel.attributedText = attributeStr;
	self.wordLibNameLabel.text = reviewModel.currentWordLibName;
	[self.tableView reloadData];
	[self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
}

#pragma mark -UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.reviewModel.dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	LGIndexReviewAlertCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LGIndexReviewAlertCell"];
	cell.subModel = self.reviewModel.dataSourceArray[indexPath.row];
	return cell;
}

#pragma mark - UITableViewDelegate

//跳过复习
- (IBAction)skipAction:(id)sender {
	if (self.delegate) {
		[self.delegate skipReview];
	}
}
//立即复习
- (IBAction)reviewAction:(id)sender {
	if (self.delegate) {
		NSInteger index = [self.tableView indexPathForSelectedRow].row;
		[self.delegate reviewWithStatus:self.reviewModel.dataSourceArray[index]];
	}
}

@end
