//
//  LGReviewWrongListController.m
//  Word
//
//  Created by Charles Cao on 2018/3/2.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGReviewWrongListController.h"
#import "LGReviewWrongCollectionCell.h"
#import "LGReviewWrongCollectionReusableView.h"
#import "LGSelectReviewTypeView.h"
#import "LGWordDetailController.h"

@interface LGReviewWrongListController ()<UICollectionViewDataSource, UICollectionViewDelegate, LGSelectReviewTypeViewDelegate>

@property (nonatomic, assign) CGFloat cellSpace; //cell 之间的距离
@property (nonatomic, assign) CGSize cellSize; //collection cell size;

@property (nonatomic, strong) NSArray<LGReviewWrongWordModel *> *modelArray;
@property (nonatomic, strong) LGSelectReviewTypeView *selectTypeView;  //选择复习方式view
@property (nonatomic, assign) LGSelectReviewType selectedReviewType;    //选择的复习方式，默认中英

@end

@implementation LGReviewWrongListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	[self configCollectionView];
	[self requestData];
	
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requestData{
	[self.request requestRevieWrongWordListCompletion:^(id response, LGError *error) {
		if ([self isNormal:error]) {
			self.modelArray = [LGReviewWrongWordModel mj_objectArrayWithKeyValuesArray:response];
			[self.collectionView  reloadData];
		}
	}];
}



/**
 选择复习方式
 */
- (IBAction)selectReviewTypeAction:(id)sender {
    
    if (!self.selectTypeView) {
        self.selectTypeView = [[NSBundle mainBundle]loadNibNamed:@"LGSelectReviewTypeView" owner:nil options:nil].firstObject;
        self.selectTypeView.frame = self.collectionView.frame;
        self.selectTypeView.delegate = self;
    }
    
    [self.view addSubview:self.selectTypeView];
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

#pragma mark - LGSelectReviewTypeViewDelegate
- (void)selectedReviewType:(LGSelectReviewType)type{
    self.selectedReviewType = type;
    NSString *str;
    switch (type) {
        case LGSelectReviewChinese_English:
            str = @"中英";
            break;
        case LGSelectReviewEnglish_Chinese:
            str = @"英中";
            break;
        case LGSelectReviewDictation:
            str = @"听写";
            break;
        default:
            break;
    }
    [self.rightItemButton setTitle:str forState:UIControlStateNormal];
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
	header.totalLabel.text = [NSString stringWithFormat:@"共 %@ 词",self.totalNum];
	return header;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ;// [self performSegueWithIdentifier:@"reviewWrongListToWordDetail" sender:self.modelArray[indexPath.row]];
    [self.request requestReviewWrongWords:@"1" Completion:^(id response, LGError *error) {
        NSLog(@"%@",response);
    }];
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"reviewWrongListToWordDetail"]) {
        LGWordDetailController *controller = segue.destinationViewController;
        controller.controllerType = LGwordDetailReview;
        controller.reviewTyep = self.selectedReviewType;
    }
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
