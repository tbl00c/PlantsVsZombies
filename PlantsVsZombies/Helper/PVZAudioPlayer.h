//
//  PVZAudioPlayer.h
//  PlantsVsZombies
//
//  Created by h1r0 on 15/8/30.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

typedef NS_ENUM(NSInteger, AudioPlayerStatus) {
    AudioPlayerStatusPlaying,
    AudioPlayerStatusPause,
    AudioPlayerStatusStop,
};

@interface PVZAudioPlayer : NSObject

@property (nonatomic, strong) AVAudioPlayer *player;
@property (nonatomic, assign) AudioPlayerStatus status;

+ (PVZAudioPlayer *) sharedAudioPlayer;
- (BOOL) playMusicByName:(NSString *)name loop:(BOOL)loop;
- (BOOL) play;
- (BOOL) pause;
- (BOOL) stop;

@end
