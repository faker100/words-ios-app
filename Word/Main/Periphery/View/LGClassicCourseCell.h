//
//  LGClassicCourseCell.h
//  Word
//
//  Created by caoguochi on 2018/4/9.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGPeripheryModel.h"

@protocol LGClassicCourseCellDelegate<NSObject>

- (void)selectedChoiceness:(LGChoicenessModel *) choiceness;

@end

@class  LGClassCourseView;
@interface LGClassicCourseCell : UITableViewCell

@property (nonatomic, strong) NSArray<LGChoicenessModel *>  *choiceness;;
@property (nonatomic, weak) id<LGClassicCourseCellDelegate> delegate;
@property (strong, nonatomic) IBOutletCollection(LGClassCourseView) NSArray *courseViewCollection;

@end

//tag 100-课程类型 ，101-标题
@interface LGClassCourseView : UIView

@property (nonatomic,strong) LGChoicenessModel *choicenessModel;

@end
