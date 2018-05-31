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
	//self.url = LOGIN_URL;
	NSDictionary *parameter = @{
					   @"userName" : username,
					   @"userPass" : password
					   };
//	//[self postRequestCompletion:completion];
	[self postRequestUrl:LOGIN_URL parameter:parameter completion:completion];
}

- (void)resetSessionRequest:(id) userInfo completion:(void (^)(void))completion{
	
	NSArray *urlArray = SESSION_URLS;
	__block BOOL loginSuccess = YES;
	dispatch_group_t requestGroup = dispatch_group_create();
	[urlArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		dispatch_group_enter(requestGroup);
//		self.url = obj;
//		NSDictionary *parameter = userInfo;
		[self getRequesttUrl:obj parameter:userInfo completion:^(id response, LGError *error) {
			if (error) {
				loginSuccess = NO;
			}
			dispatch_group_leave(requestGroup);
			NSLog(@"=====session:%@",response);
		}];
	}];
	dispatch_group_notify(requestGroup, dispatch_get_main_queue(), ^{
		
		if (loginSuccess) {
			[LGUserManager configCookie];
			if (completion) {
				completion();
			}
		}
	});
}

- (void)requestCheckCodeSure{
//	self.url = CHECK_CODE_SURE;
//	[self postRequestCompletion:nil];
	[self postRequestUrl:CHECK_CODE_SURE parameter:nil completion:nil];
}

- (void)requestCheckCode:(NSString *)username usernameType:(LGUsernameType)usernameType useType:(LGCheckCodeUseType)useType completion:(comletionBlock)completion{
	
	NSMutableDictionary *tempParameter = [NSMutableDictionary dictionary];
	[tempParameter setObject:@(useType) forKey:@"type"];
	NSString *url = @"";
	if (usernameType == LGUsernamePhoneType) {
		url = GET_CHECK_CODE_PHONE;
		[tempParameter setObject:username forKey:@"phoneNum"];
	}else{
		url = GET_CHECK_CODE_EMAIL;
		[tempParameter setObject:username forKey:@"email"];
	}
//	NSDictionary *parameter = tempParameter;
//	//[self postRequestCompletion:completion];
	[self postRequestUrl:url parameter:tempParameter completion:completion];
}


- (void)registerRequest:(NSString *)username password:(NSString *)password code:(NSString *)code usernameType:(LGUsernameType)usernameType completion:(comletionBlock)completion {
//	self.url = REGISTER_URL;
	NSDictionary *parameter = @{
					   @"type" : @(usernameType),
					   @"registerStr" : username,
					   @"pass" : password,
					   @"code" : code,
					   @"userName" : username,
					   @"source" : @"5",
					   @"belong" : @"1"
					   };
//	//[self postRequestCompletion:completion];
	[self postRequestUrl:REGISTER_URL parameter:parameter completion:completion];
}

- (void)findPasswordRequest:(NSString *)username password:(NSString *)password code:(NSString *)code usernameType:(LGUsernameType)usernameType completion:(comletionBlock)completion{
	//self.url = FIND_PASSWORD_URL;
	NSDictionary *parameter = @{
					   @"type":@(usernameType),
					   @"registerStr":username,
					   @"pass":password,
					   @"code":code
					   };
//	//[self postRequestCompletion:completion];
	[self postRequestUrl:FIND_PASSWORD_URL parameter:parameter completion:completion];
}


- (void)updateStudyType:(LGStudyType)type  completion:(comletionBlock)completion{
	//self.url = UPDATE_STUDY_TYPE_URL;
	NSDictionary *parameter = @{
					   @"status" : @(type)
					   };
	//[self postRequestCompletion:completion];
	[self postRequestUrl:UPDATE_STUDY_TYPE_URL parameter:parameter completion:completion];
}

- (void)requestUserInfo:(comletionBlock)completion{
//	self.url = USER_INFO_URL;
	//[self postRequestCompletion:completion];
	[self postRequestUrl:USER_INFO_URL parameter:nil completion:completion];
	
}

- (void)requestUserPlan:(comletionBlock)completion{
//	self.url = MY_PLAN_URL;
	//[self postRequestCompletion:completion];
	[self postRequestUrl:MY_PLAN_URL parameter:nil completion:completion];
}

- (void)requestWordLibraryList:(comletionBlock)completion{
//	self.url = WORD_LIBRARY_LIST_URL;
	//[self postRequestCompletion:completion];
	[self postRequestUrl:WORD_LIBRARY_LIST_URL parameter:nil completion:completion];
}

- (void)requestFreeLibraryWordList:(NSString *)catID page:(NSInteger)page completion:(comletionBlock)completion{
//    self.url = FREE_LIBRARY_WORD_LIST_URL;
    NSDictionary *parameter = @{
                       @"catId" : catID,
					   @"page"  : @(page)
                       };
    //[self postRequestCompletion:completion];
	[self postRequestUrl:FREE_LIBRARY_WORD_LIST_URL parameter:parameter completion:completion];
}

- (void)downloadAudioFile:(NSString *)url completion:(downloadComletionBlock)completion {
	
	NSString *fileName = [url stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
	NSString *path = [[LGTool getAudioFilePath] stringByAppendingPathComponent:fileName];
	if ([[NSFileManager defaultManager] fileExistsAtPath:path]){
		completion([NSURL fileURLWithPath:path],nil);
	}else{
		[self downloadRequest:url targetPath:[LGTool getAudioFilePath] fileName:fileName completion:completion];
	}
}

- (void)addWordLibrary:(NSString *)libraryId planDay:(NSInteger)planDay planWord:(NSInteger)planWord sortType:(LGAddPlanSortType)sortType completion:(comletionBlock)completion{
//    self.url = ADD_WORD_LIBRARY_URL;
    NSDictionary *parameter = @{
                       @"packageId" : libraryId,
                       @"planDay" : @(planDay),
                       @"planWords" : @(planWord),
					   @"rank" :  @(sortType)
                       };
    //[self postRequestCompletion:completion];
	[self postRequestUrl:ADD_WORD_LIBRARY_URL parameter:parameter completion:completion];
}

- (void)updateNowPackage:(NSString *)catID completion:(comletionBlock)completion{
	//取消上次请求
    if (self.task && [self.task.originalRequest.URL.absoluteString isEqualToString:UPDATE_NOW_PACKAGE]) {
        [self.task cancel];
    }
//    self.url = UPDATE_NOW_PACKAGE;
    NSDictionary *parameter = @{
                       @"catId" : catID
                       };
    //[self postRequestCompletion:completion];
	[self postRequestUrl:UPDATE_NOW_PACKAGE parameter:parameter completion:completion];
}

- (void)deleteWordLibrary:(NSString *)libraryId completion:(comletionBlock)completion{
//	self.url = DELETE_WORD_LIBRARY_URL;
	NSDictionary *parameter = @{
					   @"id" : libraryId
					   };
	//[self postRequestCompletion:completion];
	[self postRequestUrl:DELETE_WORD_LIBRARY_URL parameter:parameter completion:completion];
}

- (void)uploadWordLibraryArray:(NSArray<LGPlanModel *> *)libraryArray completion:(comletionBlock)completion{
//	self.url = UPLOAD_WORD_LIBRARY_URL;
	if (ArrayNotEmpty(libraryArray)) {
		NSArray *array = [LGPlanModel mj_keyValuesArrayWithObjectArray:libraryArray];
		NSData *data = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:nil];
		NSString *jsonStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
		NSDictionary *parameter = @{
						   @"data" : jsonStr
						   };
		//[self postRequestCompletion:completion];
		[self postRequestUrl:UPLOAD_WORD_LIBRARY_URL parameter:parameter completion:completion];
	}
}

- (void)requestIndexRecitePlan:(comletionBlock)completion{
//    self.url = INDEX_RECITE_PLAN_URL;
    //[self postRequestCompletion:completion];
	[self postRequestUrl:INDEX_RECITE_PLAN_URL parameter:nil completion:completion];
}

- (void)requestReciteWordsCompletion:(comletionBlock)completion{
//	self.url = WORD_DETAIL_URL;
	//[self postRequestCompletion:completion];
	[self postRequestUrl:WORD_DETAIL_URL parameter:nil completion:completion];
}

- (void)updateWordStatus:(NSString *)wordId status:(LGWordStatus)status completion:(comletionBlock)completion{
//	self.url = UPDATE_WORD_STATUS_URL;
	NSDictionary *parameter = @{
					   @"wordsId" : wordId,
					   @"status" : @(status)
					   };
	//[self postRequestCompletion:completion];
	[self postRequestUrl:UPDATE_WORD_STATUS_URL parameter:parameter completion:completion];
}

- (void)requestEbbinghausReviewList:(comletionBlock)completion{
//	self.url = EBBINGHAUS_REVIEW_LIST_URL;
	//[self postRequestCompletion:completion];
	[self postRequestUrl:EBBINGHAUS_REVIEW_LIST_URL parameter:nil completion:completion];
}

- (void)requestWordDetailWidthID:(NSString *)wordID completion:(comletionBlock)completion{
//	self.url = GET_WORD_DETAILS_URL;
	NSDictionary *parameter = @{
					   @"wordsId" : wordID,
					   };
	//[self postRequestCompletion:completion];
	[self postRequestUrl:GET_WORD_DETAILS_URL parameter:parameter completion:completion];
}

- (void)submitWordErrorWithType:(NSUInteger)type content:(NSString *)content wordId:(NSString *)wordId completion:(comletionBlock)completion{
//	self.url = WORD_ERROR_URL;
	NSDictionary *parameter = @{
					   @"type" : @(type),
					   @"wordsId" : wordId ? wordId : @"",
					   @"content" : content
					   };
	//[self postRequestCompletion:completion];
	[self postRequestUrl:WORD_ERROR_URL parameter:parameter completion:completion];
}

- (void)requestEveryDayReviewCompletion:(comletionBlock)completion{
//	self.url = EVERY_DAY_REVIEW_URL;
	//[self postRequestCompletion:completion];
	[self postRequestUrl:EVERY_DAY_REVIEW_URL parameter:nil completion:completion];
}

- (void)updateEveryDayReviewCompletion:(comletionBlock)completion{
//	self.url = UPDATE_IS_REVIEW_URL;
	//[self postRequestCompletion:completion];
	[self postRequestUrl:UPDATE_IS_REVIEW_URL parameter:nil completion:completion];
}

- (void)requestTodayReviewWordsCompletion:(comletionBlock)completion{
//	self.url = REVIEW_TODAY_URL;
	//[self postRequestCompletion:completion];
	[self postRequestUrl:REVIEW_TODAY_URL parameter:nil completion:completion];
	
}

- (void)updateReviewWordStatus:(LGWordStatus)status wordId:(NSString *)wordId type:(NSInteger)type completion:(comletionBlock)completion{
//	self.url = UPDATE_REVIEW_WORD_STATUS_URL;
	NSDictionary *parameter = @{
					   @"wordsId" : wordId,
					   @"status" :  status == LGWordStatusUnchanged ? @"" : @(status),
					   @"type" : @(type)
					   };
	//[self postRequestCompletion:completion];
	[self postRequestUrl:UPDATE_REVIEW_WORD_STATUS_URL parameter:parameter completion:completion];
	
}

- (void)finishEbbinghausCompletion:(comletionBlock)completion{
//	self.url = FINISH_EBBINGHAUS_REVIEW;
	//[self postRequestCompletion:completion];
	[self postRequestUrl:FINISH_EBBINGHAUS_REVIEW parameter:nil completion:completion];
}

- (void)requestReviewIndexCompletion:(comletionBlock)completion{
//	self.url = REVIEW_INDEX_URL;
	//[self postRequestCompletion:completion];
	[self postRequestUrl:REVIEW_INDEX_URL parameter:nil completion:completion];
}


- (void)requestRevieWrongWordListCompletion:(comletionBlock)completion{
//	self.url = REVIEW_WRONG_WORDS_LIST_URL;
	//[self postRequestCompletion:completion];
	[self postRequestUrl:REVIEW_WRONG_WORDS_LIST_URL parameter:nil completion:completion];
}

- (void)requestReviewWrongWordsWithStart:(NSString *)start Completion:(comletionBlock)completion{
    //self.url = GET_WROING_WORDS_URL;
    NSDictionary *parameter = @{
                       @"start" : start
                       };
    //[self postRequestCompletion:completion];
	[self postRequestUrl:GET_WROING_WORDS_URL parameter:parameter completion:completion];
}

- (void)requestRevieWordWithStartTime:(NSString *)startTime endTime:(NSString *)endTime Completion:(comletionBlock)completion{
//	self.url = REIVEW_TIME_URL;
	NSDictionary *parameter = @{
					   @"start" : startTime,
					   @"end" : endTime
					   };
	//[self postRequestCompletion:completion];
	[self postRequestUrl:REIVEW_TIME_URL parameter:parameter completion:completion];
}

- (void)requestDicationIndexCompletion:(comletionBlock)completion{
//	self.url = DICTATION_INDEX_URL;
	//[self postRequestCompletion:completion];
	[self postRequestUrl:DICTATION_INDEX_URL parameter:nil completion:completion];
}

- (void)requestDicationGroupWithStatus:(LGWordStatus)status completion:(comletionBlock)completion{
	//self.url = DICTATION_GROUP_URL;
	NSDictionary *parameter = @{
					   @"status" : @(status)
					   };
	//[self postRequestCompletion:completion];
	[self postRequestUrl:DICTATION_GROUP_URL parameter:parameter completion:completion];
}

- (void)requestDictationWordsWithStatus:(LGWordStatus)status start:(NSInteger)start completion:(comletionBlock)completion{
//	self.url = DICTATION_PRACTISE_URL;
	NSDictionary *parameter = @{
					   @"status" : @(status),
					   @"start" : @(start)
					   };
	//[self postRequestCompletion:completion];
	[self postRequestUrl:DICTATION_PRACTISE_URL parameter:parameter completion:completion];
}

- (void)requestPKRankCompletion:(comletionBlock)completion{
	//self.url = PK_INDEX_RANK_URL;
	//[self postRequestCompletion:completion];
	[self postRequestUrl:PK_INDEX_RANK_URL parameter:nil completion:completion];
}

- (void)uploadHeaderImage:(UIImage *)headImage completion:(comletionBlock)completion{
    NSData *imageData = UIImageJPEGRepresentation(headImage,1.0);
    [self uploadRequest:UPDATE_HEAD_IMG_URL data:imageData Completion:completion];
	
}

- (void)requestPkMatchingCompletion:(comletionBlock)completion{
//	self.url = PK_MATCHING_URL;
	//[self postRequestCompletion:completion];
	[self postRequestUrl:PK_MATCHING_URL parameter:nil completion:completion];
}

- (void)requestPkChoice:(LGPKChoice)choice opponentUid:(NSString *)uid completion:(comletionBlock)completion{
//	self.url = PK_CHOICE_URL;
	NSDictionary *parameter = @{
					   @"uid" : uid ? uid : @"",
					   @"type" : @(choice)
					   };
	//[self postRequestCompletion:completion];
	[self postRequestUrl:PK_CHOICE_URL parameter:parameter completion:completion];
}

- (void)commitPKAnswer:(LGAnswerType)type totalId:(NSString *)totalId wordId:(NSString *)wordId answer:(NSString *)answer duration:(NSInteger)duration completion:(comletionBlock)completion{
//	self.url = PK_ANSWER_URL;
	NSDictionary *parameter = @{
					   @"totalId" : totalId,
					   @"wordsId" : wordId,
					   @"answer" : answer ? answer : @"",
					   @"type" : @(type),
					   @"duration" : @(duration)
					   };
	
	//[self postRequestCompletion:completion];
	[self postRequestUrl:PK_ANSWER_URL parameter:parameter completion:completion];
}

- (void)requestPKExit:(NSString *)uid totalId:(NSString *)totalId currentQuestionIndex:(NSInteger)num duration:(NSInteger)time{
//	self.url = PK_BACKGROUND_URL;
	NSDictionary *parameter = @{
					    @"totalId" : totalId,
						@"uid" : uid,
						@"num" :@(num),
						@"time" : @(time)
					   };
//	[self postRequestCompletion:nil];
	[self postRequestUrl:PK_BACKGROUND_URL parameter:parameter completion:nil];
}

- (void)requestPKConnect:(NSString *)uid totalId:(NSString *)totalId completion:(comletionBlock)completion{
//	self.url = PK_CONNECT_URL;
	NSDictionary *parameter = @{
					   @"uid" : uid,
					   @"totalId" : totalId,
					   };
    //[self postRequestCompletion:completion];
	[self postRequestUrl:PK_CONNECT_URL parameter:parameter completion:completion];
}

- (void)updatePhone:(NSString *)phone code:(NSString *)code completion:(comletionBlock)completion{
//    self.url = UPDATE_USER_URL;
    NSDictionary *parameter = @{
                       @"uid" : [LGUserManager shareManager].user.uid,
                       @"phone" : phone,
                       @"code" : code
                       };
    //[self postRequestCompletion:completion];
		[self postRequestUrl:UPDATE_USER_URL parameter:parameter completion:completion];
}

- (void)updateEmail:(NSString *)emial code:(NSString *)code completion:(comletionBlock)completion{
//    self.url = UPDATE_USER_URL;
    NSDictionary *parameter = @{
                       @"uid" : [LGUserManager shareManager].user.uid,
                       @"email" : emial,
                       @"code" : code
                       };
    //[self postRequestCompletion:completion];
	[self postRequestUrl:UPDATE_USER_URL parameter:parameter completion:completion];
}

- (void)updatePassword:(NSString *)oldPassword newPassword:(NSString *)newPassword completion:(comletionBlock)completion{
//    self.url = UPDATE_USER_URL;
    NSDictionary *parameter = @{
                       @"uid" : [LGUserManager shareManager].user.uid,
                       @"oldPass" : oldPassword,
                       @"newPass" : newPassword
                       };
    //[self postRequestCompletion:completion];
	[self postRequestUrl:UPDATE_USER_URL parameter:parameter completion:completion];
}

- (void)updateNickname:(NSString *)nickname completion:(comletionBlock)completion{
//	self.url = UPDATE_NICKNAME_URL;
	NSDictionary *parameter = @{
					   @"nickname" : nickname
					   };
	//[self postRequestCompletion:completion];
	[self postRequestUrl:UPDATE_NICKNAME_URL parameter:parameter completion:completion];
}

- (void)requestPKFinish:(NSString *)uid totalId:(NSString *)totalId completion:(comletionBlock)completion{
//	self.url = PK_FINISH_URL;
	NSDictionary *parameter = @{
					   @"uid" : uid,
					   @"totalId" : totalId
					   };
	//[self postRequestCompletion:completion];
	[self postRequestUrl:PK_FINISH_URL parameter:parameter completion:completion];
}

- (void)requestPKResult:(NSString *)uid totalId:(NSString *)totalId completion:(comletionBlock)completion{
//	self.url = PK_RESULT_URL;
	NSDictionary *parameter = @{
					   @"uid" : uid,
					   @"totalId" : totalId
					   };
	//[self postRequestCompletion:completion];
	[self postRequestUrl:PK_RESULT_URL parameter:parameter completion:completion];
}

- (void)requestPKPoll:(NSString *)opponentUid totalId:(NSString *)totalId completion:(comletionBlock)completion{
//	self.url = PK_POLL_URL;
	NSDictionary *parameter = @{
					   @"uid2" : opponentUid,
					   @"totalId" : totalId
					   };
	//[self postRequestCompletion:completion];
	[self postRequestUrl:PK_POLL_URL parameter:parameter completion:completion];
}

- (void)requestPKDiscoverWithPage:(NSInteger)page completion:(comletionBlock)completion{
//    self.url = PK_DISCOVER_URL;
    NSDictionary *parameter = @{
                       @"page" : @(page),
                       @"pageSize" : @"20"
                       };
    //[self postRequestCompletion:completion];
	[self postRequestUrl:PK_DISCOVER_URL parameter:parameter completion:completion];
}

- (void)reqeustTrackCompletion:(comletionBlock)completion{
//	self.url = PK_TACK_URL;
	//[self postRequestCompletion:completion];
	[self postRequestUrl:PK_TACK_URL parameter:nil completion:completion];
}

- (void)requestBeginEstimateCompletion:(comletionBlock)completion{
//    self.url = BEGIN_ESTIMATE_URL;
//    [self postRequestCompletion:comletion];
	[self postRequestUrl:BEGIN_ESTIMATE_URL parameter:nil completion:completion];
}

- (void)reqeustEstimateWordsCompletion:(comletionBlock)completion{
//    self.url = ESTIMATE_WORD_URL;
    //[self postRequestCompletion:completion];
	[self postRequestUrl:ESTIMATE_WORD_URL parameter:nil completion:completion];
}

- (void)submitEstimateAnswer:(NSString *)answer type:(LGAnswerType)type wordId:(NSString *)wordId duration:(NSInteger)duration isKnow:(BOOL)isKnow completion:(comletionBlock)completion{
//	self.url = SUBMIT_ESTIMATE_ANSWER_URL;
	NSDictionary *parameter = @{
					   @"wordsId" :wordId,
					   @"type" : @(type),
					   @"answer" : answer ? answer : @"",
					   @"duration" : @(duration),
					   @"status" : isKnow ? @"0" : @"1"
					   };
	//[self postRequestCompletion:completion];
	[self postRequestUrl:SUBMIT_ESTIMATE_ANSWER_URL parameter:parameter completion:completion];
}

- (void)requestRankList:(NSString *)page pageSize:(NSString *)pageSize completion:(comletionBlock)completion{
//	self.url = ESTIMATE_LIST_URL;
	NSDictionary *parameter = @{
					   @"page" : page,
					   @"pageSize" : pageSize
					   };
	//[self postRequestCompletion:completion];
	[self postRequestUrl:ESTIMATE_LIST_URL parameter:parameter completion:completion];
}

- (void)requestEstimateResultCompletion:(comletionBlock)completion{
//	self.url = ESTIMATE_RESULT_RUL;
	//[self postRequestCompletion:completion];
	[self postRequestUrl:ESTIMATE_RESULT_RUL parameter:nil completion:completion];
}

- (void)requestReportCompletion:(comletionBlock)completion{
//	self.url = WORD_REPORT_URL;
	//[self postRequestCompletion:completion];
	[self postRequestUrl:WORD_REPORT_URL parameter:nil completion:completion];
}

- (void)requestChangeMonthReport:(NSString *)month completion:(comletionBlock)completion{
//	self.url = CHAGNE_REPORT_URL;
	NSDictionary *parameter = @{
					   @"month" : month
					   };
	
	//[self postRequestCompletion:completion];
	[self postRequestUrl:CHAGNE_REPORT_URL parameter:parameter completion:completion];
}

- (void)requestRimCompletion:(comletionBlock)completion{
//	self.url = PERIPHERY_URL;
	//[self postRequestCompletion:completion];
	[self postRequestUrl:PERIPHERY_URL parameter:nil completion:completion];
}

- (void)requestCourseListWithType:(LGCourseType)type completion:(comletionBlock)completion{
//	self.url = COURSE_LIST_URL;
	NSDictionary *parameter = @{
					   @"type":@(type)
					   };
	//[self postRequestCompletion:completion];
	[self postRequestUrl:COURSE_LIST_URL parameter:parameter completion:completion];
}

- (void)requestPublickListWithPage:(NSInteger)page completion:(comletionBlock)completion{
//	self.url = PUBLIC_LIST_URL;
	NSDictionary *parameter = @{
					   @"page" : @(page),
					   @"pageSize" : @"20"
					   };
	//[self postRequestCompletion:completion];
	[self postRequestUrl:PUBLIC_LIST_URL parameter:parameter completion:completion];
}

- (void)requestCaseListCompletion:(comletionBlock)completion{
//	self.url = CASE_LIST_URL;
	//[self postRequestCompletion:completion];
	[self postRequestUrl:CASE_LIST_URL parameter:nil completion:completion];
}

- (void)reqeustSignCompletion:(comletionBlock)completion{
//	self.url = SIGN_URL;
	//[self postRequestCompletion:completion];
	[self postRequestUrl:SIGN_URL parameter:nil completion:completion];
}

- (void)requestUserSignCompletion:(comletionBlock)completion{
//	self.url = SIGN_LIST_URL;
	//[self postRequestCompletion:completion];
		[self postRequestUrl:SIGN_LIST_URL parameter:nil completion:completion];
}

- (void)requestSearchWordWithStr:(NSString *)str completion:(comletionBlock)completion{
    if (self.task) {
        [self.task cancel];
    }
	
//	self.url = SEARCH_WORD_RUL;
	NSDictionary *parameter = @{
					   @"str" : str
					   };
	//[self postRequestCompletion:completion];
	[self postRequestUrl:SEARCH_WORD_RUL parameter:parameter completion:completion];
}

- (void)requestIsReciteWordsCompletion:(comletionBlock)completion{
//    self.url = CONTINUE_RECITE_WORD_URL;
    //[self postRequestCompletion:completion];
	[self postRequestUrl:CONTINUE_RECITE_WORD_URL parameter:nil completion:completion];
}

- (void)submitIdea:(NSString *)str completion:(comletionBlock)completion{
//	self.url = SUBMIT_IDEA_URL;
	NSDictionary *parameter = @{
					   @"content" : str
					   };
	//[self postRequestCompletion:completion];
	[self postRequestUrl:SUBMIT_IDEA_URL parameter:parameter completion:completion];
}

@end
