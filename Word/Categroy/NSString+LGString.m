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

- (BOOL)isRightPassword{
	NSString *passWordRegex = @"^[a-zA-Z0-9]{6,20}";
	NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
	return [passWordPredicate evaluateWithObject:self];
}

- (BOOL)isNickname{
	NSString *nicknameRegex = @"[\u4e00-\u9fa5a-zA-Z0-9]{2,8}";
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", nicknameRegex];
	return [predicate evaluateWithObject:self];
}

- (CGFloat)getStringRectWidthOfHeight:(CGFloat)height fontSize:(CGFloat)fontSize{
	
	NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
	CGRect rect = [self boundingRectWithSize:CGSizeMake(0, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
	return  rect.size.width;
}

- (CGFloat)getStringRectHeightOfWidth:(CGFloat)width fontSize:(CGFloat)fontSize{
	
	NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
	CGRect rect = [self boundingRectWithSize:CGSizeMake(width, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
	return  rect.size.height;
}

//替换多余行高
- (NSString *)replaceParagraphSpace{
	NSString *returnStr = [self stringByReplacingOccurrencesOfString:@"<p><br/></p>" withString:@""];
	NSString *space = @"<p><span style=\"font-family: 微软雅黑, &#39;Microsoft YaHei&#39;; font-size: 12px;\"><br/></span></p>";
	returnStr = [self stringByReplacingOccurrencesOfString:space withString:@""];
	returnStr = [self stringByReplacingOccurrencesOfString:@"<p> </p>" withString:@""];
	returnStr = [self stringByReplacingOccurrencesOfString:@"<p><br/></p>" withString:@""];
	return returnStr;
}

//替换完整图片地址
- (NSString *)replaceImageUrl:(NSString *)imageUrlStr  htmlStr:(NSString *)htmlStr{
	NSString *returnStr = htmlStr;
	NSString *regexString = @"<img.*?\\ssrc=\".*?\"";
	NSRegularExpression *reqular = [NSRegularExpression regularExpressionWithPattern:regexString options:NSRegularExpressionDotMatchesLineSeparators error:nil];
	NSArray *resultArray  = [reqular matchesInString:htmlStr options:NSMatchingReportCompletion range:NSMakeRange(0, htmlStr.length)];
	if (resultArray && resultArray.count > 0) {
		for (NSTextCheckingResult *result in resultArray) {
			NSRange range = result.range;
			NSString *subStr = [htmlStr substringWithRange:range];
			if (!( [subStr containsString:@" src=\"http"] || [subStr containsString:@"data:image"])) {
				NSRange srcRange = [subStr rangeOfString:@" src=\""];
				NSMutableString *tempStr =  [[NSMutableString alloc]initWithString:subStr];
				[tempStr insertString:imageUrlStr atIndex:NSMaxRange(srcRange)];
				returnStr = [htmlStr stringByReplacingOccurrencesOfString:subStr withString:tempStr];
				return [self replaceImageUrl:imageUrlStr htmlStr:returnStr];
			}
		}
	}
	return returnStr;
}


- (void)htmlToAttributeStringContent:(NSString *)imageUrl width:(CGFloat)contentWidth completion:(void (^)(NSMutableAttributedString *))completion{
	
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		NSString *str  = [self replaceImageUrl:imageUrl htmlStr:self ];
		str = [str replaceParagraphSpace];
		
		NSData *htmlData = [str dataUsingEncoding:NSUTF8StringEncoding];
		NSDictionary *importParams = @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
									   NSCharacterEncodingDocumentAttribute: [NSNumber numberWithInt:NSUTF8StringEncoding]
									   };
		NSError *error = nil;
		NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithData:htmlData options:importParams documentAttributes:NULL error:&error];
		[attributeString enumerateAttribute:NSAttachmentAttributeName inRange:NSMakeRange(0, attributeString.length) options:NSAttributedStringEnumerationReverse usingBlock:^(id  _Nullable value, NSRange range, BOOL * _Nonnull stop) {
			if (value) {
				NSTextAttachment *textAttachment = value;
				CGSize size = textAttachment.bounds.size;
				if (size.width > contentWidth) {
					textAttachment.bounds = CGRectMake(0, 0, contentWidth-5, size.height / size.width * (contentWidth-5));
				}
			}
		}];
	
		// 回到主线程
		dispatch_async(dispatch_get_main_queue(), ^{
			completion(attributeString);
		});
	});
}

@end
