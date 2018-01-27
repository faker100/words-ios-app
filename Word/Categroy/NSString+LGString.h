//
//  NSString+LGString.h
//  Word
//
//  Created by Charles Cao on 2018/1/22.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LGString)

- (BOOL)isPhoneNum;
- (BOOL)isEmail;
- (BOOL)isRightPassword;

@end
