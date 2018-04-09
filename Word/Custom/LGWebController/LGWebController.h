//
//  HTWebController.h
//  GMat
//
//  Created by hublot on 2017/4/24.
//  Copyright © 2017年 thinku. All rights reserved.
//

#import "AXWebViewController.h"

@interface LGWebController : AXWebViewController

@property (nonatomic, copy) void(^customShareBlock)(NSString *currentTitle, NSString *currentUrl);

+ (instancetype)contactAdvisorWebController;

@end
