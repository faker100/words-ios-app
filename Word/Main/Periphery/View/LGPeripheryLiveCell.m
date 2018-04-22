//
//  LGPeripheryLiveCell.m
//  Word
//
//  Created by Charles Cao on 2018/4/8.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGPeripheryLiveCell.h"

@implementation LGPeripheryLiveCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setLivePreview:(NSArray<LGLivePreviewModel *> *)livePreview{
    if (_livePreview != livePreview) {
        _livePreview = livePreview;
        [self.tableView reloadData];
    }
}

#pragma mark -UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return self.livePreview.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.livePreview[section].data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	LGLivePreviewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LGLivePreviewCell"];
    cell.classModel = self.livePreview[indexPath.section].data[indexPath.row];
    cell.delegate = self.delegate;
	return cell;
}

#pragma mark -UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	if (self.delegate) {
		LGLivePreviewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
		[self.delegate selectedModel:cell.classModel];
	}
}

@end
