//
//  LGWordDetailModel.m
//  Word
//
//  Created by Charles Cao on 2018/2/8.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGWordDetailModel.h"

@implementation LGWordDetailModel

+ (NSDictionary *)mj_objectClassInArray{
	return @{
			 @"sentence" : @"LGSentenceModel",
			 @"lowSentence" : @"LGSentenceModel"
			 };
}

- (void)mj_keyValuesDidFinishConvertingToObject{
	
	self.dataSource = [NSMutableArray array];
	
	if (StringNotEmpty(self.words.mnemonic)) {
		LGWordDetailTableDataSource *dataSource = [[LGWordDetailTableDataSource alloc]init];
		dataSource.sectionTitle = @"助记";
		[dataSource.cellContent addObject:self.words.mnemonic];
		[self.dataSource addObject:dataSource];
	}
	if (ArrayNotEmpty(self.lowSentence)) {
		LGWordDetailTableDataSource *dataSource = [[LGWordDetailTableDataSource alloc]init];
		dataSource.sectionTitle = @"短句";
		[self.lowSentence enumerateObjectsUsingBlock:^(LGSentenceModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
			NSString *str = [NSString stringWithFormat:@"%@\n%@",obj.english,obj.chinese];
			[dataSource.cellContent addObject:str];
		}];
		[self.dataSource addObject:dataSource];
	}
	if (ArrayNotEmpty(self.sentence)) {
		LGWordDetailTableDataSource *dataSource = [[LGWordDetailTableDataSource alloc]init];
		dataSource.sectionTitle = @"例句";
		[self.sentence enumerateObjectsUsingBlock:^(LGSentenceModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
			NSString *str = [NSString stringWithFormat:@"%@\n%@",obj.english,obj.chinese];
			[dataSource.cellContent addObject:str];
		}];
		[self.dataSource addObject:dataSource];
	}
}

@end


@implementation LGSentenceModel

@end

@implementation LGWordDetailTableDataSource

- (instancetype)init{
	self = [super init];
	if (self) {
		self.cellContent = [NSMutableArray array];
	}
	return self;
}

@end
