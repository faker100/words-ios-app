//
//  LGPlayer.m
//  Word
//
//  Created by Charles Cao on 2018/2/1.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import "LGPlayer.h"
#import "NSObject+LGRequest.h"
#import "LGTool.h"
#import <AVFoundation/AVFoundation.h>

@interface LGPlayer ()

@property (nonatomic, strong) NSCache *cache;
@property (nonatomic, strong) AVAudioPlayer *player;

@end

@implementation LGPlayer


+ (instancetype)sharedPlayer {
	static LGPlayer *sharedPlayer = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedPlayer = [[LGPlayer alloc] init];
	});
	return sharedPlayer;
}

- (void)playWithUrl:(NSString *)url{
	
	[self.request downloadRequest:url targetPath:[LGTool getAudioFilePath] completion:^(NSURL *filePath, LGError *error) {
		if (!error) {
			NSError *error;
			self.player = [[AVAudioPlayer alloc]initWithContentsOfURL:filePath error:&error];
			NSLog(@"%@",error);
			[self.player play];
		}
	}];
}
							   

- (NSCache *)cache{
	if (!_cache) {
		_cache = [[NSCache alloc]init];
	}
	return _cache;
}

@end
