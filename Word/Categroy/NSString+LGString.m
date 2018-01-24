//
//  NSString+LGString.m
//  Word
//
//  Created by Charles Cao on 2018/1/22.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "NSString+LGString.h"

@implementation NSString (LGString)

- (BOOL)isPhoneNum{
	
	NSString *phoneRegex = @"^1(3|4|9|5|7|8)\\d{9}$";
	NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
	return [phoneTest evaluateWithObject:self];
}


- (BOOL)isEmail{
	NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
	NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
	return [emailTest evaluateWithObject:self];
}

@end
