//
//  LGSimilarWordsCell.m
//  Word
//
//  Created by Charles Cao on 2018/5/31.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGSimilarWordsCell.h"
#import "LGSimilarWordsCollectionCell.h"
#import "NSString+LGString.h"
#import "LGUserManager.h"

@interface LGSimilarWordsCell() <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@end

@implementation LGSimilarWordsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 15, 0, 15);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setSimilarWords:(NSArray<LGSimilarWordsModel *> *)similarWords{
	if (_similarWords != similarWords) {
		_similarWords = similarWords;
		
		UICollectionViewFlowLayout  *flowLayout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
		
		[self.collectionView reloadData];
		self.collectionHeightConstraint.constant = flowLayout.collectionViewContentSize.height;
	}
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
	return self.similarWords.count;
//	return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
	
	LGSimilarWordsCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LGSimilarWordsCollectionCell" forIndexPath:indexPath];
	cell.similarWord = self.similarWords[indexPath.row];
	return cell;
}

#pragma mark - UICollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
	NSString *text = self.similarWords[indexPath.row].word;
	CGFloat width = [text getStringRectWidthOfHeight:0 fontSize:14 + [LGUserManager shareManager].user.fontSizeRate.floatValue];
	return CGSizeMake(ceil(width), 30);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
	[self.delegate selectedSimilar:self.similarWords[indexPath.row]];
}

@end

@implementation LGEquestSpaceLayout



-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
	NSArray *original = [super layoutAttributesForElementsInRect:rect];
	
    NSArray *attributes = [[NSArray alloc] initWithArray:original copyItems:YES];
    
	UICollectionViewLayoutAttributes *firstLayoutAttributes = attributes[0];
	firstLayoutAttributes.frame = CGRectMake(self.sectionInset.left, firstLayoutAttributes.frame.origin.y, firstLayoutAttributes.frame.size.width, firstLayoutAttributes.frame.size.height);
	
	for(int i = 1; i < [attributes count]; ++i) {
		//当前attributes
		UICollectionViewLayoutAttributes *currentLayoutAttributes = attributes[i];
		//上一个attributes
		UICollectionViewLayoutAttributes *prevLayoutAttributes = attributes[i - 1];
		//我们想设置的最大间距，可根据需要改
		NSInteger maximumSpacing = 10;
		//前一个cell的最右边
		NSInteger origin = CGRectGetMaxX(prevLayoutAttributes.frame);
		//如果当前一个cell的最右边加上我们想要的间距加上当前cell的宽度依然在contentSize中，我们改变当前cell的原点位置
		//不加这个判断的后果是，UICollectionView只显示一行，原因是下面所有cell的x值都被加到第一行最后一个元素的后面了
		if(origin + maximumSpacing + currentLayoutAttributes.frame.size.width < self.collectionViewContentSize.width) {
			CGRect frame = currentLayoutAttributes.frame;
			frame.origin.x = origin + maximumSpacing;
			currentLayoutAttributes.frame = frame;
		}
	}
	
	return attributes;
}

@end

