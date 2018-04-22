//
//  LGPKDiscoverCell.m
//  Word
//
//  Created by Charles Cao on 2018/4/4.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGPKDiscoverCell.h"

@interface LGPKDiscoverCell ()

@property (nonatomic, strong) CAShapeLayer *maskLayer;

@end

@implementation LGPKDiscoverCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setDiscoverModel:(LGPKDiscoverModel *)discoverModel{
	_discoverModel = discoverModel;
	[self.bgImageView sd_setImageWithURL:[NSURL URLWithString:WORD_DOMAIN(discoverModel.image)]];
	self.discoverTitleLabel.text = discoverModel.title;
    if (discoverModel.date) {
        self.dateLabel.hidden = NO;
        self.dateLabel.text = discoverModel.date;
        [self.dateLabel.layer insertSublayer:self.maskLayer atIndex:0];
    }else{
        self.dateLabel.hidden = YES;
    }
	
}

- (CAShapeLayer *)maskLayer{
    if (!_maskLayer) {
        CGRect rect = CGRectMake(0, 0, 150, 24);
        UIBezierPath *path = [[UIBezierPath alloc]init];
        [path moveToPoint:CGPointZero];
        [path addLineToPoint:CGPointMake(0, CGRectGetHeight(rect))];
        [path addLineToPoint:CGPointMake(CGRectGetWidth(rect) - 10, CGRectGetHeight(rect))];
        [path addLineToPoint:CGPointMake(CGRectGetWidth(rect), 0)];
        [path closePath];
        _maskLayer = [CAShapeLayer new];
        _maskLayer.path = path.CGPath;
        _maskLayer.fillColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4].CGColor;
        _maskLayer.frame = rect;
    }
    return _maskLayer;
}

@end





