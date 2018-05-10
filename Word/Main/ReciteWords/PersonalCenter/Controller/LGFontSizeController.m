//
//  LGFontSizeController.m
//  Word
//
//  Created by Charles Cao on 2018/3/28.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGFontSizeController.h"
#import "LGUserManager.h"

//sliderView 每格的差是1，乘以倍数改变每格的差
#define multiple 1.5

@interface LGFontSizeController ()
{
    CGFloat originalFontSize;
}
@end

@implementation LGFontSizeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    originalFontSize = self.fontSizeLabel.font.pointSize;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-2 -1 0 1 2
//初始值为中间,或者本地记录值

- (void)viewDidLayoutSubviews{

	//本地字体加减
	NSString *localFontSizeRate = [LGUserManager shareManager].user.fontSizeRate;
	
	[self.slider setValue:localFontSizeRate.floatValue/multiple  animated:YES];
}

- (IBAction)valueChangedAction:(UISlider *)sender {

	//四舍五入,获取正确的 fontSize
	NSInteger fontSize = round(sender.value);
	/*
	 * UISlider宽度比自定义滑条宽度多30,左右多15,需要对应调整,使其适应自定义滑条
	 * 如果滑块滑动到中间,则跟自定义滑条一致
	 * 如果滑块不在中间,则相应 减少/增加 自定义滑条与 UISlider 的差距
	 */
	CGFloat fixSliderValue = fontSize;
	
	//UISlider 的范围 与 UISliser 的宽度比例
	CGFloat ratio = (sender.maximumValue - sender.minimumValue) / sender.frame.size.width;
	
	//获取中间值的 fontsize
	CGFloat centerFontSize = [self sliderMidValue];
	
	//7.5 (为UISlider比自定义滑块多出的30 / 4),使滑块中心停留在自定义滑条的分割线上.
	if (fontSize > centerFontSize) fixSliderValue -= 7.5 * ratio;
	if (fontSize < centerFontSize) fixSliderValue += 7.5 * ratio;
	
	[sender setValue:fixSliderValue animated:YES];
	
    //最终值为两倍slider的值
	[LGUserManager shareManager].user.fontSizeRate = @(fixSliderValue * multiple).stringValue;
    self.fontSizeLabel.font = [UIFont systemFontOfSize:originalFontSize +  fixSliderValue * multiple];
}

//slider中间值，作为比例参考
- (CGFloat) sliderMidValue{
    return (self.slider.maximumValue + self.slider.minimumValue) / 2;
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
