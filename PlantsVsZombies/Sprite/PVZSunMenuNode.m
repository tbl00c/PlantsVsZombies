//
//  PVZSunMenuNode.m
//  PlantsVsZombies
//
//  Created by h1r0 on 15/9/11.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import "PVZSunMenuNode.h"

@interface PVZSunMenuNode ()

@property (nonatomic, strong) SKLabelNode *sunValueNode;

@property (nonatomic, strong) SKAction *cannotChooseAction;

@end


@implementation PVZSunMenuNode

+ (id) createSunMenuNodeWithSunValue:(int)sunValue
{
    PVZSunMenuNode *node = [PVZSunMenuNode spriteNodeWithImageNamed:@"SunBack"];
    [node setSize:CGSizeMake(WIDTH_SUNMENU, HEIGHT_SUNMENU)];
    [node setSunValue:sunValue];
    
    return node;
}

#pragma mark - 加减阳光值

- (void) setSunValue:(int)sunValue
{
    _sunValue = sunValue;
    if (_sunValueNode == nil) {
        _sunValueNode = [SKLabelNode labelNodeWithText:@"0"];
        [_sunValueNode setFontName:@"Impact"];
        [_sunValueNode setFontColor:[UIColor blackColor]];
        [_sunValueNode setFontSize:25.0f];
        [_sunValueNode setPosition:CGPointMake(WIDTH_SUNMENU * 0.12, - HEIGHT_SUNMENU * 0.28)];
        [self addChild:_sunValueNode];
        SKAction *moveRight = [SKAction moveBy:CGVectorMake(10, 0) duration:0.06];
        SKAction *moveLeft = [SKAction moveBy:CGVectorMake(-20, 0) duration:0.12];
        SKAction *moveMid = [SKAction moveBy:CGVectorMake(10, 0) duration:0.06];
        SKAction *moveSqeuque = [SKAction sequence:@[moveRight, moveLeft, moveMid]];
        SKAction *repeatMove = [SKAction repeatAction:moveSqeuque count:2];
        SKAction *wait = [SKAction waitForDuration:0.05];
        _cannotChooseAction = [SKAction sequence:@[repeatMove, wait]];
    }
    [_sunValueNode setText:[NSString stringWithFormat:@"%d", sunValue]];
    if (_delegate && [_delegate respondsToSelector:@selector(sunMenuNodeDidUpdateSunValue:)]) {
        [_delegate sunMenuNodeDidUpdateSunValue:_sunValue];
    }
}

- (void) addSunValue:(int)value
{
    [self setSunValue:_sunValue + value];
}

- (BOOL) subSunValue:(int)value
{
    if (_sunValue < value) {
        return NO;
    }
    [self setSunValue: _sunValue - value];
    return YES;
}

- (BOOL) canSubSunValue:(int)value withAnimation:(BOOL)animation
{
    if (_sunValue < value) {
        if (animation) {
            self.sunValueNode.fontColor = [UIColor redColor];
            [self.sunValueNode runAction: _cannotChooseAction completion:^{
                self.sunValueNode.fontColor = [SKColor blackColor];
            }];
            //FIXME: 第一次动画卡顿
        }
        return NO;
    }
    return YES;
}

@end
