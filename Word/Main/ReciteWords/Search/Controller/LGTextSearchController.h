//
//  LGTextSearchController.h
//  Word
//
//  Created by caoguochi on 2018/4/15.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGSearchModel.h"

@protocol LGTextSearchControllerDelegate <NSObject>

- (void)selctedSearchModel:(LGSearchModel *)searchModel;

@end

@interface LGTextSearchController : UIViewController <UITableViewDelegate,UITableViewDataSource, UISearchDisplayDelegate, UISearchResultsUpdating>

@property (nonatomic,weak) id<LGTextSearchControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
