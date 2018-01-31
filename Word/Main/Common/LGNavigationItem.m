//
//  LGNavigationItem.m
//  Word
//
//  Created by Charles Cao on 2018/1/30.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGNavigationItem.h"

@implementation LGNavigationItem

- (void)awakeFromNib{
	[super awakeFromNib];
    self.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
}

@end
