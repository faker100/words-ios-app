//
//  LGSimilarWordsCell.m
//  Word
//
//  Created by Charles Cao on 2018/5/31.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGSimilarWordsCell.h"
#import "LGSimilarWordsCollectionCell.h"

@interface LGSimilarWordsCell() <UICollectionViewDataSource, UICollectionViewDelegate>
@end

@implementation LGSimilarWordsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setSimilarWords:(NSArray<LGSimilarWordsModel *> *)similarWords{
	if (_similarWords != similarWords) {
		_similarWords = similarWords;
		[self.collectionView reloadData];
	}
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
	return self.similarWords.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
	
	LGSimilarWordsCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LGSimilarWordsCollectionCell" forIndexPath:indexPath];
	cell.similarWord = self.similarWords[indexPath.row];
	return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
	[self.delegate selectedSimilar:self.similarWords[indexPath.row]];
}


@end
