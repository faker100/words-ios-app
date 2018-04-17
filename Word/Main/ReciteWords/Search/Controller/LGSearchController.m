//
//  LGSearchController.m
//  Word
//
//  Created by Charles Cao on 2018/4/17.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGSearchController.h"


@implementation LGSearchController

- (void)viewDidLoad{
	[super viewDidLoad];
	self.searchBar.text = self.defaultText;
}

- (instancetype)initWithText:(NSString *)text delegate:( id<LGTextSearchControllerDelegate>) delegate{
	
	LGTextSearchController *resultController =  STORYBOARD_VIEWCONTROLLER(@"ReciteWords", @"LGTextSearchController");
	
	self = [super initWithSearchResultsController:resultController];
	if (self) {
		self.defaultText = text;
		resultController.delegate = delegate;
		self.searchBar.tintColor = [UIColor lg_colorWithType:LGColor_theme_Color];
		self.searchResultsUpdater = resultController;
	}
	return self;
}

@end
