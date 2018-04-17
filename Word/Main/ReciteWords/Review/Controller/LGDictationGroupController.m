//
//  LGDicationGroupController.m
//  Word
//
//  Created by Charles Cao on 2018/4/17.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGDictationGroupController.h"
#import "LGReviewWrongCollectionCell.h"
#import "LGReviewWrongCollectionReusableView.h"
#import "LGReviewWrongWordModel.h"
#import "LGDictationPractiseController.h"

@interface LGDictationGroupController ()

@property (nonatomic, assign) CGFloat cellSpace; //cell 之间的距离
@property (nonatomic, assign) CGSize cellSize; //collection cell size;
@property (nonatomic, strong) NSArray<LGReviewWrongWordModel *> *modelArray;

@end

@implementation LGDictationGroupController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	[self configCollectionView];
	[self requestData];
	

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requestData{
	[LGProgressHUD showHUDAddedTo:self.view];
	[self.request requestDicationGroupWithStatus:self.status completion:^(id response, LGError *error) {
		if ([self isNormal:error]) {
			self.modelArray = [LGReviewWrongWordModel mj_objectArrayWithKeyValuesArray:response];
			if (!self.totalNum) self.totalNum = self.modelArray.lastObject.end;
			[self.collectionView  reloadData];
		}
		
	}];
}

- (void)configCollectionView{
	[self.collectionView registerNib:[UINib nibWithNibName:@"LGReviewWrongCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LGReviewWrongCollectionReusableView"];
	UICollectionViewFlowLayout  *flowLayout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
	flowLayout.minimumLineSpacing = self.cellSpace;
	flowLayout.minimumInteritemSpacing = self.cellSpace;
	flowLayout.itemSize = self.cellSize;
	flowLayout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 40);
	self.collectionView.contentInset = UIEdgeInsetsMake(0, self.cellSpace, 0, self.cellSpace);
}

#pragma mark - setter getter

/**
 iphone 5 屏幕上一行3个,下缩小 cell size;
 ipad 中 size 为 (110, 60) 间距为 10;
 */
- (CGFloat)cellSpace{
	
	if ([[UIDevice currentDevice].model isEqualToString:@"iPhone"]){
		return SCREEN_WIDTH == 320 ? 5 : (SCREEN_WIDTH - (3 * 110)) / 4.0f;
	}else{
		return 10;
	}
}

- (CGSize)cellSize{
	return SCREEN_WIDTH == 320 ? CGSizeMake(100, 60) : CGSizeMake(110, 60);
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
	return self.modelArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
	LGReviewWrongCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LGReviewWrongCollectionCell" forIndexPath:indexPath];
	cell.wrongWordModel = self.modelArray[indexPath.row];
	return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
	
	LGReviewWrongCollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"LGReviewWrongCollectionReusableView" forIndexPath:indexPath];
	header.totalLabel.text = [NSString stringWithFormat:@"共 %ld 词",self.totalNum.integerValue];
	return header;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
	
	[self requestDictationWordsWithStart:self.modelArray[indexPath.row].start.integerValue];
	
}

#pragma mark -

/**
 请求分组单词

 @param start 分组开始个数
 */
- (void)requestDictationWordsWithStart:(NSInteger)start{
	[LGProgressHUD showHUDAddedTo:self.view];
	[self.request requestDictationWordsWithStatus:self.status start:start completion:^(id response, LGError *error) {
		if ([self isNormal:error]) {
			NSMutableArray *wordIDArray = [NSMutableArray arrayWithArray:response];
			[self performSegueWithIdentifier:@"dictationGroupToPractise" sender:wordIDArray];
		}
	}];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	
	LGDictationPractiseController *controller = segue.destinationViewController;
	controller.wordIDArray = sender;
	controller.total = @(((NSMutableArray *)sender).count).stringValue;
	
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
