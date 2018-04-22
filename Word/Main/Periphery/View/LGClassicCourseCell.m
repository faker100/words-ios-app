//
//  LGClassicCourseCell.m
//  Word
//
//  Created by caoguochi on 2018/4/9.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGClassicCourseCell.h"

@implementation LGClassicCourseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.courseViewCollection enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [obj addGestureRecognizer:tap];
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setChoiceness:(NSArray<LGChoicenessModel *> *)choiceness{
    if (_choiceness != choiceness) {
        _choiceness = choiceness;
        [self.courseViewCollection enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            LGClassCourseView *courseView = obj;
            if (idx < choiceness.count) {
                courseView.choicenessModel = choiceness[idx];
            }
        }];
    }
    
}

- (void)tapAction:(UITapGestureRecognizer *)tap{
    [self.delegate selectedChoiceness:((LGClassCourseView *)tap.view).choicenessModel];
}

@end


@implementation LGClassCourseView


- (void)setChoicenessModel:(LGChoicenessModel *)choicenessModel{
    _choicenessModel = choicenessModel;
    UILabel *courseTypeLabel = [self viewWithTag:100];
    UILabel *titleLabel = [self viewWithTag:101];
    switch (choicenessModel.courseType) {
        case LGCourseGMAT:
            courseTypeLabel.text = @" GMAT ";
            break;
        case LGCourseTOEFL:
            courseTypeLabel.text = @" TOEFL ";
            break;
        case LGCourseIELTS:
            courseTypeLabel.text = @" IELTS ";
            break;
        case LGCourseSat:
            courseTypeLabel.text = @" SAT ";
            break;
        case LGCourseGRE:
            courseTypeLabel.text = @" GRE ";
            break;
        case LGCourseSchool:
            courseTypeLabel.text = @" 留学 ";
            break;
        default:
            break;
    }
    titleLabel.text = choicenessModel.name;
}

@end
