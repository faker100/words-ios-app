//
//  LGSearchController.h
//  Word
//
//  Created by Charles Cao on 2018/4/17.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGTextSearchController.h"

@interface LGSearchController : UISearchController

//默认搜索字符串
@property (nonatomic, copy) NSString *defaultText;

- (instancetype)initWithText:(NSString *)text delegate:( id<LGTextSearchControllerDelegate>) delegate;

@end

