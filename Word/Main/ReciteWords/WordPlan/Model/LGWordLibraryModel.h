//
//  LGWordLibraryModel.h
//  Word
//
//  Created by Charles Cao on 2018/1/31.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LGChildWordLibraryModel;

//词库价格
typedef NS_ENUM(NSUInteger, LGWordLibraryPrice) {
	LGWordLibraryFree = 1,
	LGWordLibraryCharge,
	
};

@interface LGWordLibraryModel : NSObject

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, assign) LGWordLibraryPrice type;
@property (nonatomic, copy) NSArray<LGChildWordLibraryModel *> *child;

@end

@interface LGChildWordLibraryModel : NSObject

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *total;
@property (nonatomic, copy) NSString *userWords;

@end
