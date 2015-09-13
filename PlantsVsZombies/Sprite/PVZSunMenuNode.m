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
#ifdef DEBUG_SUN_INFINATE
    [node setSunValue:5000];
#else
    [node setSunValue:sunValue];
#endif
    
    return node;
}

- (SKLabelNode *) sunValueNode
{
    if (!_sunValueNode) {
        _sunValueNode = [SKLabelNode labelNodeWithFontNamed:@"0"];
        [_sunValueNode setFontName:@"Impact"];
        [_sunValueNode setFontColor:[UIColor blackColor]];
        [_sunValueNode setFontSize:25.0f];
        [_sunValueNode setPosition:CGPointMake(WIDTH_SUNMENU * 0.12, - HEIGHT_SUNMENU * 0.28)];
        [_sunValueNode setZPosition:1];
        [self addChild:_sunValueNode];
        SKAction *moveRight = [SKAction moveBy:CGVectorMake(10, 0) duration:0.06];
        SKAction *moveLeft = [SKAction moveBy:CGVectorMake(-20, 0) duration:0.12];
        SKAction *moveMid = [SKAction moveBy:CGVectorMake(10, 0) duration:0.06];
        SKAction *moveSqeuque = [SKAction sequence:@[moveRight, moveLeft, moveMid]];
        SKAction *repeatMove = [SKAction repeatAction:moveSqeuque count:2];
        SKAction *wait = [SKAction waitForDuration:0.05];
        _cannotChooseAction = [SKAction sequence:@[repeatMove, wait]];
    }
    return _sunValueNode;
}

#pragma mark - 加减阳光值

- (void) setSunValue:(int)sunValue
{
    _sunValue = sunValue;
    //FIXME: 第一次操作会卡顿
    [self.sunValueNode setText:[NSString stringWithFormat:@"%d", sunValue]];
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
        }
        return NO;
    }
    return YES;
}

@end
