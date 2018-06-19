//
//  LGSoundTableViewController.m
//  Word
//
//  Created by Charles Cao on 2018/6/19.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGSoundTableViewController.h"
#import "LGUserManager.h"

@interface LGSoundTableViewController ()

@end

@implementation LGSoundTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.tableView.tableFooterView = [UIView new];
	[self configDefault];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//配置所有开关
- (void)configDefault{
	[self.flagSwitchArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		UISwitch *switchView = obj;
		NSInteger tag = switchView.tag;
		switch (tag) {
			case 100:
				switchView.on = [LGUserManager shareManager].indexSoundFlag;
				break;
			case 101:
				switchView.on = ![LGUserManager shareManager].wordDetailSoundFlag ;
				break;
			case 102:
				switchView.on = [LGUserManager shareManager].wordEstimateSoundFlag ;
				break;
			case 103:
				switchView.on = [LGUserManager shareManager].pkResultSoundFlag;
				break;
			case 104:
				switchView.on = [LGUserManager shareManager].pkBackGroundSoundFlag;
				break;
			case 105:
				switchView.on = [LGUserManager shareManager].autoplayWordFlag;
				break;
			default:
				break;
		}
	}];
}

/**
 音效快关

 @param sender 快关
 tag - 100 首页音效
 tag - 101 背单词音效
 tag - 102 单词评估音效
 tag - 103 pk 结果页音效
 tag - 104 pk 背景音乐
 tag - 105 自动发音
 */
- (IBAction)soundFlagAction:(UISwitch *)sender {
	NSInteger tag = sender.tag;
	switch (tag) {
		case 100:
			[LGUserManager shareManager].indexSoundFlag = sender.isOn;
			break;
		case 101:
			[LGUserManager shareManager].wordDetailSoundFlag = !sender.isOn;
			break;
		case 102:
			[LGUserManager shareManager].wordEstimateSoundFlag = sender.isOn;
			break;
		case 103:
			[LGUserManager shareManager].pkResultSoundFlag = sender.isOn;
			break;
		case 104:
			[LGUserManager shareManager].pkBackGroundSoundFlag = sender.isOn;
			break;
		case 105:
			[LGUserManager shareManager].autoplayWordFlag = sender.isOn;
			break;
		default:
			break;
	}
}



#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
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
