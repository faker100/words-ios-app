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
- (BOOL)isNickname;

/**
 根据指定宽度下,获取文本高度

 @param width 指定宽度
 @param fontSize 字体大小
 @return 高度
 */
- (CGFloat)getStringRectHeightOfWidth:(CGFloat)width fontSize:(CGFloat)fontSize;


/**
 根据指定高度下,获取文本高度
 
 @param height 指定高度
 @param fontSize 字体大小
 @return 宽度
 */
- (CGFloat)getStringRectWidthOfHeight:(CGFloat)height fontSize:(CGFloat)fontSize;

//替换多余行高
- (NSString *)replaceParagraphSpace;

//替换完整图片地址
- (NSString *)replaceImageUrl:(NSString *)imageUrlStr htmlStr:(NSString *)htmlStr;

//HTML 转换 attributeString
- (NSAttributedString *)htmlToAttributeStringContent:(NSString *)imageUrl width:(CGFloat)contentWidth;

@end
