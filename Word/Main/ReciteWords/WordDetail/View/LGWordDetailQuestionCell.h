//
//  LGWordDetailQuestionCell.h
//  Word
//
//  Created by Charles Cao on 2018/4/20.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LGWordDetailQuestionCell : UITableViewCell

@property (nonatomic, copy) NSString *question;

@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UILabel *questionLabel;

- (void)setQuestion:(NSString *)question completion:(void(^)(void))completion;

@end
