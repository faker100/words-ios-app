//
//  LGWordLibraryTypeCell.h
//  Word
//
//  Created by Charles Cao on 2018/1/30.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGWordLibraryModel.h"

@interface LGWordLibraryTypeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *libraryImageView;
@property (weak, nonatomic) IBOutlet UILabel *libraryTitleLabel;
@property (nonatomic, strong) LGWordLibraryModel *wordLibrary;

@end
