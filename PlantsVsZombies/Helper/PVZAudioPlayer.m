//
//  PVZAudioPlayer.m
//  PlantsVsZombies
//
//  Created by h1r0 on 15/8/30.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import "PVZAudioPlayer.h"

static PVZAudioPlayer *audioPlayer = nil;

@implementation PVZAudioPlayer

+ (PVZAudioPlayer *) sharedAudioPlayer
{
    if (audioPlayer == nil) {
        audioPlayer = [[PVZAudioPlayer alloc] init];
        audioPlayer.status = AudioPlayerStatusStop;
    }
    return audioPlayer;
}

- (BOOL) playMusicByName:(NSString *)name loop:(BOOL)loop
{
    if (_status != AudioPlayerStatusStop) {
        [self stop];
    }
    NSError *error;
    NSURL *url = [[NSBundle mainBundle] URLForResource:name withExtension:nil];
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    _player.numberOfLoops = loop ? -1 : 1;
    if (error) {
        PVZLogError([self class], @"playMusicByName: loop:", error);
        return NO;
    }
    [_player play];
    return YES;
}

- (BOOL) play
{
    if (_status == AudioPlayerStatusPlaying) {
        PVZLogWarning([self class], @"paly", @"Player is not stop or pause when u call this method");
        return NO;
    }
    [_player play];
    return YES;
}

- (BOOL) pause
{
    if (_status != AudioPlayerStatusPlaying) {
        PVZLogWarning([self class], @"pause", @"Player is not playing status when u call this method");
        return NO;
    }
    
    return YES;
}

- (BOOL) stop
{
    [_player stop];
    return YES;
}

@end
