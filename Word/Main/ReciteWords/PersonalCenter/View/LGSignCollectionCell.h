//
//  LGSignCollectionCell.h
//  Word
//
//  Created by Charles Cao on 2018/4/10.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LGSignType) {
	LGSignNone,  //未打卡
	LGSignDidSign, //已经打卡
	LGsignToday,  //今天且未打卡
};

@class LGSignCellModel;
@interface LGSignCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIButton *dayButton;
@property (nonatomic, strong) LGSignCellModel *signModel;

@end


@interface LGSignCellModel : NSObject

@property (nonatomic, assign) LGSignType signType;
@property (nonatomic, strong) NSString *day;

@end
