//
//  LGRequest.m
//  Word
//
//  Created by Charles Cao on 2018/1/19.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGRequest.h"
#import "NSString+LGString.h"
#import "LGUserManager.h"
#import "LGTool.h"
#import "LGPlanModel.h"

@implementation LGRequest


- (void)loginRequest:(NSString *)username password:(NSString *)password completion:(comletionBlock)completion{
	self.url = LOGIN_URL;
	self.parameter = @{
					   @"userName" : username,
					   @"userPass" : password
					   };
	[self postRequestCompletion:^(id response, LGError *error) {
		if (error) {
            completion(response,error);
        }else{
            [self resetSessionRequest:response completion:^{
                completion(response,error);
            }];
        }
	}];
}

- (void)resetSessionRequest:(id) userInfo completion:(void (^)(void))completion{
	
	NSArray *urlArray = SESSION_URLS;
	dispatch_group_t requestGroup = dispatch_group_create();
	[urlArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		dispatch_group_enter(requestGroup);
		self.url = obj;
		self.parameter = userInfo;
		[self getRequestCompletion:^(id response, LGError *error) {
			dispatch_group_leave(requestGroup);
			NSLog(@"=====session:%@",response);
		}];
	}];
	dispatch_group_notify(requestGroup, dispatch_get_main_queue(), ^{
		
		[LGUserManager configCookie];
		if (completion) {
			completion();
		}
	});
}

- (void)requestCheckCodeSure{
	self.url = CHECK_CODE_SURE;
	[self postRequestCompletion:nil];
}

- (void)requestCheckCode:(NSString *)username usernameType:(LGUsernameType)usernameType useType:(LGCheckCodeUseType)useType completion:(comletionBlock)completion{
	self.parameter = (NSMutableDictionary *)self.parameter;
	[self.parameter setValue:@(useType) forKey:@"type"];
	if (usernameType == LGUsernamePhoneType) {
		self.url = GET_CHECK_CODE_PHONE;
		[self.parameter setValue:username forKey:@"phoneNum"];
	}else{
		self.url = GET_CHECK_CODE_EMAIL;
		[self.parameter setValue:username forKey:@"email"];
	}
	[self postRequestCompletion:completion];
}


- (void)registerRequest:(NSString *)username password:(NSString *)password code:(NSString *)code usernameType:(LGUsernameType)usernameType completion:(comletionBlock)completion {
	self.url = REGISTER_URL;
	self.parameter = @{
					   @"type" : @(usernameType),
					   @"registerStr" : username,
					   @"pass" : password,
					   @"code" : code,
					   @"userName" : username,
					   @"source" : @"5",
					   @"belong" : @"1"
					   };
	[self postRequestCompletion:completion];
}

- (void)findPasswordRequest:(NSString *)username password:(NSString *)password code:(NSString *)code usernameType:(LGUsernameType)usernameType completion:(comletionBlock)completion{
	self.url = FIND_PASSWORD_URL;
	self.parameter = @{
					   @"type":@(usernameType),
					   @"registerStr":username,
					   @"pass":password,
					   @"code":code
					   };
	[self postRequestCompletion:completion];
}


- (void)updateStudyType:(LGStudyType)type  completion:(comletionBlock)completion{
	self.url = UPDATE_STUDY_TYPE_URL;
	self.parameter = @{
					   @"status" : @(type)
					   };
	[self postRequestCompletion:completion];
}

- (void)requestUserInfo:(comletionBlock)completion{
	self.url = USER_INFO_URL;
	[self postRequestCompletion:completion];
}

- (void)requestUserPlan:(comletionBlock)completion{
	self.url = MY_PLAN_URL;
	[self postRequestCompletion:completion];
}

- (void)requestWordLibraryList:(comletionBlock)completion{
	self.url = WORD_LIBRARY_LIST_URL;
	[self postRequestCompletion:completion];
}

- (void)requestFreeLibraryWordList:(NSString *)catID page:(NSInteger)page completion:(comletionBlock)completion{
    self.url = FREE_LIBRARY_WORD_LIST_URL;
    self.parameter = @{
                       @"catId" : catID,
					   @"page"  : @(page)
                       };
    [self postRequestCompletion:completion];
}

- (void)downloadAudioFile:(NSString *)url completion:(downloadComletionBlock)completion {
	
	NSString *fileName = [url stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
	NSString *path = [[LGTool getAudioFilePath] stringByAppendingPathComponent:fileName];
	if ([[NSFileManager defaultManager] fileExistsAtPath:path]){
		completion([NSURL URLWithString:path],nil);
	}else{
		[self downloadRequest:url targetPath:[LGTool getAudioFilePath] fileName:fileName completion:completion];
	}
}

- (void)addWordLibrary:(NSString *)libraryId completion:(comletionBlock)completion {
	self.url = ADD_WORD_LIBRARY_URL;
	self.parameter = @{
					   @"packageId" : libraryId
					   };
	[self postRequestCompletion:completion];
}

- (void)deleteWordLibrary:(NSString *)libraryId completion:(comletionBlock)completion{
	self.url = DELETE_WORD_LIBRARY_URL;
	self.parameter = @{
					   @"id" : libraryId
					   };
	[self postRequestCompletion:completion];
}

- (void)uploadWordLibraryArray:(NSArray<LGPlanModel *> *)libraryArray completion:(comletionBlock)completion{
	self.url = UPLOAD_WORD_LIBRARY_URL;
	if (ArrayNotEmpty(libraryArray)) {
		NSArray *array = [LGPlanModel mj_keyValuesArrayWithObjectArray:libraryArray];
		NSData *data = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:nil];
		NSString *jsonStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
		self.parameter = @{
						   @"data" : jsonStr
						   };
		[self postRequestCompletion:completion];
	}
}

- (void)requestIndexRecitePlan:(comletionBlock)completion{
    self.url = INDEX_RECITE_PLAN_URL;
    [self postRequestCompletion:completion];
}

- (void)requestReciteWordsCompletion:(comletionBlock)completion{
	self.url = WORD_DETAIL_URL;
	[self postRequestCompletion:completion];
}

- (void)updateWordStatus:(NSString *)wordId status:(LGWordStatus)status completion:(comletionBlock)completion{
	self.url = UPDATE_WORD_STATUS_URL;
	self.parameter = @{
					   @"wordsId" : wordId,
					   @"status" : @(status)
					   };
	[self postRequestCompletion:completion];
}

- (void)requestEbbinghausReviewList:(comletionBlock)completion{
	self.url = EBBINGHAUS_REVIEW_LIST_URL;
	[self postRequestCompletion:completion];
}

- (void)requestWordDetailWidthID:(NSString *)wordID completion:(comletionBlock)completion{
	self.url = GET_WORD_DETAILS_URL;
	self.parameter = @{
					   @"wordsId" : wordID,
					   };
	[self postRequestCompletion:completion];
	
}

- (void)submitWordErrorWithType:(NSUInteger)type content:(NSString *)content wordId:(NSString *)wordId completion:(comletionBlock)completion{
	self.url = WORD_ERROR_URL;
	self.parameter = @{
					   @"type" : @(type),
					   @"wordsId" : wordId ? wordId : @"",
					   @"content" : content
					   };
	[self postRequestCompletion:completion];
}

- (void)requestEveryDayReviewCompletion:(comletionBlock)completion{
	self.url = EVERY_DAY_REVIEW_URL;
	[self postRequestCompletion:completion];
}

- (void)updateEveryDayReviewCompletion:(comletionBlock)completion{
	self.url = UPDATE_IS_REVIEW_URL;
	[self postRequestCompletion:completion];
}

- (void)requestTodayReviewWordsWithStatus:(LGWordStatus)status completion:(comletionBlock)completion{
	self.url = REVIEW_TODAY_URL;
	self.parameter = @{
					   @"status" :@(status)
					   };
	[self postRequestCompletion:completion];
}

- (void)updateReviewWordStatus:(LGWordStatus)status wordId:(NSString *)wordId completion:(comletionBlock)completion{
	self.url = UPDATE_REVIEW_WORD_STATUS_URL;
	self.parameter = @{
					   @"wordsId" : wordId,
					   @"status" : @(status)
					   };
	[self postRequestCompletion:completion];
	
}

- (void)requestReviewIndexCompletion:(comletionBlock)completion{
	self.url = REVIEW_INDEX_URL;
	[self postRequestCompletion:completion];
}


- (void)requestRevieWrongWordListCompletion:(comletionBlock)completion{
	self.url = REVIEW_WRONG_WORDS_LIST_URL;
	[self postRequestCompletion:completion];
}

- (void)requestReviewWrongWords:(NSString *)start Completion:(comletionBlock)completion{
    self.url = GET_WROING_WORDS_URL;
    self.parameter = @{
                       @"start" : start
                       };
    [self postRequestCompletion:completion];
}

@end
