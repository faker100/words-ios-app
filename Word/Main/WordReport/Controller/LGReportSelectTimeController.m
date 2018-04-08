//
//  LGReportSelectTimeController.m
//  Word
//
//  Created by Charles Cao on 2018/4/8.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGReportSelectTimeController.h"
#import "NSDate+Utilities.h"

@interface LGReportSelectTimeController () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) NSMutableArray *years;
@property (nonatomic, strong) NSMutableArray *thisYearMonths; //今年月份

@property (nonatomic, assign) NSInteger currentYear;//今年;

@property (nonatomic, strong) NSString *selectedYear; //选择年份,默认years中第一年;


@end

@implementation LGReportSelectTimeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.currentYear = [NSDate currentDate].year;
	self.selectedYear = self.years.firstObject;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
	//[self.picker selectRow:self.thisYearMonths.count - 1 inComponent:self.years.count - 1 animated:YES];
}

- (NSMutableArray *)years{
	if (!_years) {
		_years = [NSMutableArray array];
		
		for (int i = 2015; i<=self.currentYear; i++) {
			[_years addObject:@(i).stringValue];
		}
	}
	return _years;
}

- (NSMutableArray *)thisYearMonths{
	if (!_thisYearMonths) {
		_thisYearMonths = [NSMutableArray array];
		NSInteger currentMonth = [NSDate currentDate].month;
		for (int i = 1; i<=currentMonth; i++) {
			[_thisYearMonths addObject:@(i).stringValue];
		}
	}
	return _thisYearMonths;
}

- (IBAction)sureAction:(id)sender {
	if (self.delegate) {
		NSInteger monthIndex = [self.picker selectedRowInComponent:1];
		NSString *str = [NSString stringWithFormat:@"%@-%ld-01",self.selectedYear,monthIndex + 1];
		[self.delegate selectedTime:str];
	}
	[self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
	return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
	if (component == 0) {
		return self.years.count;
	}else{
		if (self.selectedYear.integerValue == self.currentYear) {
			return self.thisYearMonths.count;
		}else{
			return 12;
		}
	}
}



#pragma mark - UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
	if (component == 0) {
		return self.years[row];
	}else{
		if (self.selectedYear.integerValue == self.currentYear) {
			return self.thisYearMonths[row];
		}else{
			return @(row + 1).stringValue;
		}
	}
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
	
	if (component == 0) {
		self.selectedYear = self.years[row];
		[pickerView reloadComponent:1];
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
