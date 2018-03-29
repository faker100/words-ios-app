//
//  LGAddClockController.m
//  Word
//
//  Created by Charles Cao on 2018/3/29.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGAddClockController.h"
#import "LGChooseWeekController.h"

@interface LGAddClockController () <UIPickerViewDelegate, UIPickerViewDataSource,LGChooseWeekControllerDelegate>

@end

@implementation LGAddClockController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.weakLabel.text = [self.clockModel weakStr];
	[self.pickerView selectRow:self.clockModel.hour inComponent:0 animated:YES];
	[self.pickerView selectRow:self.clockModel.minute inComponent:1 animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (LGClockModel *)clockModel{
	if (!_clockModel) {
		_clockModel = [LGClockModel new];
		_clockModel.isUse = YES;
	}
	return _clockModel;
}

- (IBAction)sureAction:(id)sender {
	self.clockModel.hour   = [self.pickerView selectedRowInComponent:0];
	self.clockModel.minute = [self.pickerView selectedRowInComponent:1];
	[self.delegate saveClock:self.clockModel];
	[self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
	return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
	return component == 0 ? 24 : 60;
}

#pragma mark - UIPickerViewDelegate

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
	return 38;
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
	
	NSString *temp = [NSString stringWithFormat:@"%02ld%@",row,component == 0 ? @"时" : @"分"];
	
	NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc]initWithString:temp];
	[attributeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:26] range:NSMakeRange(0, 2)];
	[attributeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(2, 1)];
	[attributeStr addAttribute:NSForegroundColorAttributeName value:[UIColor lg_colorWithType:LGColor_Title_2_Color] range:NSMakeRange(0, temp.length)];
	return attributeStr;
}

#pragma mark - LGChooseWeekControllerDelegate
- (void)selectedWeek:(NSArray *)weakArr{
	self.clockModel.week = weakArr;
	self.weakLabel.text = [self.clockModel weakStr];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString:@"addClockToChooseWeek"]) {
		LGChooseWeekController *weekController = segue.destinationViewController;
		weekController.delegate = self;
		weekController.defaultSelect = self.clockModel.week;
	}
}


@end
