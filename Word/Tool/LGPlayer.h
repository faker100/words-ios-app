//
//  LGPlayer.h
//  Word
//
//  Created by Charles Cao on 2018/2/1.
//  Copyright © 2018年 Charles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LGPlayer : NSObject

+ (instancetype)sharedPlayer;

- (void)playWithUrl:(NSString *)url;

@end
