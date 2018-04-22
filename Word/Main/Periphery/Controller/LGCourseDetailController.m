//
//  LGCourseDetailController.m
//  Word
//
//  Created by Charles Cao on 2018/4/9.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGCourseDetailController.h"
#import "LGWebController.h"
#import "NSString+LGString.h"
#import "LGNavigationController.h"
#import "LGTryListenController.h"

@interface LGCourseDetailController ()

@end

@implementation LGCourseDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[self configData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
	
}

- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
    [((LGNavigationController *)self.navigationController) transparenceBar:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
	[super viewWillDisappear:animated];
    [((LGNavigationController *)self.navigationController) transparenceBar:NO];
}

- (void)configData{
	[self.imageView sd_setImageWithURL:[NSURL URLWithString:self.courseModel.image] placeholderImage:PLACEHOLDERIMAGE];
	self.nameLabel.text = self.courseModel.name;
	self.joinNumLabel.text = [NSString stringWithFormat:@"%@人已加入",self.courseModel.view];
	
    __weak typeof(self) weakSelf = self;
	[self.courseModel.content htmlToAttributeStringContent:@"" width:SCREEN_WIDTH completion:^(NSMutableAttributedString *attrStr) {
        weakSelf.contentTextView.attributedText = attrStr;
        
        [weakSelf.activityView stopAnimating];
	}];
}

//咨询
- (IBAction)adviceAction:(id)sender {
	LGWebController *web = [LGWebController contactAdvisorWebController];
	[self.navigationController pushViewController:web animated:YES];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"courseDetailToPlayer"]) {
        LGTryListenController *controller = segue.destinationViewController;
        controller.courseModel = self.courseModel;
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
