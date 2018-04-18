//
//  LGVoiceSearchController.m
//  Word
//
//  Created by Charles Cao on 2018/4/18.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGVoiceSearchController.h"
#import "IFlyMSC/IFlyMSC.h"

@interface LGVoiceSearchController ()<IFlySpeechRecognizerDelegate>

@property (nonatomic, strong) IFlySpeechRecognizer *iFlySpeechRecognizer;
@property (nonatomic, strong) NSMutableString *resultStr; //结果;

@end

@implementation LGVoiceSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismissAction:(id)sender {
	[self dismissViewControllerAnimated:YES completion:nil];
}

//手势点击空白
- (IBAction)tapDismissAction:(id)sender {
	[self dismissViewControllerAnimated:YES completion:nil];
}
//录音
- (IBAction)voiceAction:(UIButton *)sender {
	

	self.resultStr = [NSMutableString string];
	[self.iFlySpeechRecognizer cancel];
	BOOL ret = [self.iFlySpeechRecognizer startListening];
	if (ret) {
		NSLog(@"开始录音");
	}else{
		NSLog(@"失败");
	}
	
}

- (IFlySpeechRecognizer *)iFlySpeechRecognizer{
	if (!_iFlySpeechRecognizer) {
		//创建语音识别对象
		_iFlySpeechRecognizer = [IFlySpeechRecognizer sharedInstance];
		
		[_iFlySpeechRecognizer setParameter:IFLY_AUDIO_SOURCE_MIC forKey:@"audio_source"];
		//设置为听写模式
		[_iFlySpeechRecognizer setParameter: @"iat" forKey: [IFlySpeechConstant IFLY_DOMAIN]];
		//asr_audio_path 是录音文件名，设置value为nil或者为空取消保存，默认保存目录在Library/cache下。
		[_iFlySpeechRecognizer setParameter:nil forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
		 [_iFlySpeechRecognizer setParameter:[IFlySpeechConstant LANGUAGE_ENGLISH] forKey:[IFlySpeechConstant LANGUAGE]];
		[_iFlySpeechRecognizer setParameter:@"" forKey:[IFlySpeechConstant ACCENT]];
		_iFlySpeechRecognizer.delegate = self;
		
//		IATConfig *instance = [IATConfig sharedInstance];
//		instance.language = [IFlySpeechConstant LANGUAGE_ENGLISH];
//		instance.accent = @"";
	}
	return _iFlySpeechRecognizer;
}

#pragma mark - IFlySpeechRecognizerDelegate


//识别结果返回代理
- (void) onResults:(NSArray *) results isLast:(BOOL)isLast{
	
	NSMutableString *tempResultString = [[NSMutableString alloc] init];
	NSDictionary *dic = results[0];
	
	for (NSString *key in dic) {
		[tempResultString appendFormat:@"%@",key];
	}
	
	[self.resultStr appendString:tempResultString];
	
	NSString *resultFromJson = [LGVoiceSearchController stringFromJson:tempResultString];
//	NSString * resultFromJson =  [ISRDataHelper stringFromJson:resultString];
//	_textView.text = [NSString stringWithFormat:@"%@%@", _textView.text,resultFromJson];
	
	if (isLast){
		NSLog(@"结果：%@",  resultFromJson);
	}
}
//识别会话结束返回代理
- (void)onError: (IFlySpeechError *) error{
	
}
//停止录音回调
- (void) onEndOfSpeech{
	
}
//开始录音回调
- (void) onBeginOfSpeech{
	
}
//音量回调函数
- (void) onVolumeChanged: (int)volume{
	
}
//会话取消回调
- (void) onCancel{
	
}

#pragma mark - ISRDataHelper

/**
 parse JSON data
 params,for example：
 {"sn":1,"ls":true,"bg":0,"ed":0,"ws":[{"bg":0,"cw":[{"w":"白日","sc":0}]},{"bg":0,"cw":[{"w":"依山","sc":0}]},{"bg":0,"cw":[{"w":"尽","sc":0}]},{"bg":0,"cw":[{"w":"黄河入海流","sc":0}]},{"bg":0,"cw":[{"w":"。","sc":0}]}]}
 **/
+ (NSString *)stringFromJson:(NSString*)params
{
	if (params == NULL) {
		return nil;
	}
	
	NSMutableString *tempStr = [[NSMutableString alloc] init];
	NSDictionary *resultDic  = [NSJSONSerialization JSONObjectWithData:
								[params dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
	
	if (resultDic!= nil) {
		NSArray *wordArray = [resultDic objectForKey:@"ws"];
		
		for (int i = 0; i < [wordArray count]; i++) {
			NSDictionary *wsDic = [wordArray objectAtIndex: i];
			NSArray *cwArray = [wsDic objectForKey:@"cw"];
			
			for (int j = 0; j < [cwArray count]; j++) {
				NSDictionary *wDic = [cwArray objectAtIndex:j];
				NSString *str = [wDic objectForKey:@"w"];
				[tempStr appendString: str];
			}
		}
	}
	return tempStr;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
