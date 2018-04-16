//
//  LGBaiduOcrManager.m
//  Word
//
//  Created by Charles Cao on 2018/4/16.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGBaiduOcrManager.h"
#import "NSDate+Utilities.h"

static NSString *kHTBaiduOcrKey = @"kHTBaiduOcrKey";

static NSString *kHTBaiduOcrApiKey = @"bXYKXZ0KhpdrZsAbsq2MRPte";

static NSString *kHTBaiduOcrSecretKey = @"amZ3IMbbAjH2qStVvYGYstrrUfKfqrgu";

@implementation LGBaiduOcrManager

+ (void)requestWithImage:(UIImage *)image complete:(void (^)(NSString *))complete{
	
	[LGBaiduOcrManager reqeustBaiduOauthToken:^(NSString *access_token) {
		
		NSData *data = UIImageJPEGRepresentation(image, 1.0f);
		NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];
	
		encodedImageStr = [encodedImageStr stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
		encodedImageStr = [encodedImageStr stringByReplacingOccurrencesOfString:@"/" withString:@"%2F"];
		encodedImageStr = [encodedImageStr stringByReplacingOccurrencesOfString:@"=" withString:@"%3D"];
		
		NSURLSession *session = [NSURLSession sharedSession];
		NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://aip.baidubce.com/rest/2.0/ocr/v1/general_basic?access_token=%@",access_token]];
		
		
		NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
		request.HTTPMethod = @"POST";
		[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
		[request setHTTPBody:[[NSString stringWithFormat:@"probability=true&language_type=ENG&image=%@", encodedImageStr] dataUsingEncoding:NSUTF8StringEncoding]];
		
		NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
			if (error) {
				complete(@"");
				return;
			}
			NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
			NSString *error_code = [dic objectForKey:@"error_code"];
			if (error_code.length > 0) {
				NSInteger code = error_code.integerValue;
				if (code == 100 || code == 110 || code == 111) {
					[LGBaiduOcrManager reqeustBaiduOauthToken:nil];
					complete(@"");
					return;
				}
			}else{
				NSArray *array = [dic objectForKey:@"words_result"];
				if (array.count > 0) {
					complete(array.firstObject[@"words"]);
				}else{
					complete(@"");
				}
				return;
			}
			complete(@"");
		}];
		[dataTask resume];
	}];
}

+ (void)reqeustBaiduOauthToken:(void(^)(NSString *access_token))complete{
	
	LGBaiduTokenModel *tokenModel = [LGBaiduTokenModel mj_objectWithKeyValues:[[NSUserDefaults standardUserDefaults] objectForKey:kHTBaiduOcrKey]];
	if (tokenModel && tokenModel.isValid && complete) {
		complete(tokenModel.token);
	}else{
	
	NSURLSession *session = [NSURLSession sharedSession];
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://aip.baidubce.com/oauth/2.0/token?grant_type=client_credentials&client_id=%@&client_secret=%@&",kHTBaiduOcrApiKey,kHTBaiduOcrSecretKey]];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
	request.HTTPMethod = @"POST";
	NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
		if (error == nil) {
			NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
			NSString *access_token = dic[@"access_token"];
	
			LGBaiduTokenModel *tokenModel = [LGBaiduTokenModel new];
			tokenModel.token = access_token;
			tokenModel.createTime = [[NSDate date] timeIntervalSince1970];
			[[NSUserDefaults standardUserDefaults]setObject:[tokenModel mj_keyValues] forKey:kHTBaiduOcrKey];
			if (complete) {
				complete(access_token);
			}
		}
	}];
	[dataTask resume];
	}
}

@end


@implementation LGBaiduTokenModel

- (BOOL)isValid{
	if (self.token.length == 0) return NO;
	
	if ([[NSDate date]timeIntervalSince1970] - self.createTime < 3600 * 24 * 25 ) {
		return YES;
	}else{
		return NO;
	}
}

@end
